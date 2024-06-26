import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pianote/models/pdf_file.dart';
import 'package:pianote/models/pdf_list.dart';
import 'package:pianote/utils/file_size_util.dart';


class PdfManager extends ChangeNotifier {
  List<PdfFile> _markedPdfFile = <PdfFile>[];
  bool isMarking = false;
  
  static const _dirPaths = {
    'Files': '/storage/emulated/0/Documents/pianote',
    // 'Favorites': '/storage/emulated/0/Documents/pianote/favorites'
  };
  // Map<String, String> _dirPaths = {};
  Map<String, PdfListDir> _pdfListDirs = Map<String, PdfListDir>();

  int get markedCount => _markedPdfFile.length;
  PdfFile get getmarkedPdf => _markedPdfFile.first;

  // remove pdf file from disk
  Future<void> removeFiles(String listName) async {
    while (_markedPdfFile.isNotEmpty) {
      final PdfFile file = _markedPdfFile.removeLast();
      File deleteFile = File(file.path);
      await deleteFile.delete();
      PdfListDir listDir = _pdfListDirs[listName]!;
      listDir.remove(file);
      _pdfListDirs[listName] = listDir;
    }

    notifyListeners();
  }

  // rename pdf file
  Future<String?> renamePdfFile(String newName, String listName) async {
    final pdfFile = File(_markedPdfFile.first.path);
    final newFileName = newName + '.pdf';
    final newPath =
        pdfFile.path.replaceFirst(_markedPdfFile.first.title, newFileName);
    print(File(newPath).existsSync());
    if (File(newPath).existsSync() &&
        newFileName != _markedPdfFile.first.title) {
      return 'file already exists';
    } else {
      await pdfFile.rename(newPath);
      PdfListDir listDir = _pdfListDirs[listName]!;
      var index = listDir.pdfFiles
          .indexWhere((file) => file.title == _markedPdfFile.first.title);

      final newPdf = PdfFile(newFileName, "", _markedPdfFile.first.size, newPath);
      listDir.update(newPdf, index);
      _pdfListDirs[listName] = listDir;
      notifyListeners();
    }
  }

  // move pdf files to new path
  Future<void> moveFile(String from, String to) async {
    while (_markedPdfFile.isNotEmpty) {
      PdfFile file = _markedPdfFile.removeLast();
      File sourceFile = File(file.path);
      final newPath =
          '${_dirPaths["Files"]}/$to/${file.path.split('/').last}';
      try {
        await sourceFile.rename(newPath);
      } on FileSystemException catch (e) {
        print(e.osError);
        await sourceFile.copy(newPath);
        await sourceFile.delete();
      }
      final addListName = to;
      final removeListName = from;

      // remove from PdfList model
      removePdfFromList(removeListName, file);

      // add to PdfList model
      final newFile = PdfFile(file.title, "", file.size, newPath);
      addPdfToList(addListName, newFile);
    }

    notifyListeners();
  }

  // remove pdf file from list
  void removePdfFromList(String listName, PdfFile file) {
    final listDir = _pdfListDirs[listName]!;
    listDir.remove(file);
    _pdfListDirs[listName] = listDir;
  }

  // add pdf file to list
  void addPdfToList(String listName, PdfFile file) {
    final listDir = _pdfListDirs[listName]!;
    listDir.add(file);
    _pdfListDirs[listName] = listDir;
  }

  // return dir pdfs
  Future<List<PdfFile>> getPdfs(String dirName, {String query = ''}) async {
    if (_pdfListDirs.containsKey(dirName) && _pdfListDirs[dirName] != null) {
      List<PdfFile> pdfFiles = _pdfListDirs[dirName]!.pdfFiles;

      // Filter the list based on the query
      if (query.isNotEmpty || query!.length != 0) {
        pdfFiles = pdfFiles.where((pdf) => pdf.title.contains(query)).toList();
      }
      return pdfFiles;
    } else {
      // Return an empty list or handle the error as needed
      return [];
    }
  }

  // create app dirs
  static void createDirs() {
    // Directory? fileDirectory = await getExternalStorageDirectory();
    // _dirPaths['Files'] = fileDirectory.toString().replaceAll(RegExp(",|!|'"), "");
    // _dirPaths['Favorites'] = p.join(fileDirectory.toString().replaceAll(RegExp(",|!|'"), ""), 'favorites');
    final List<String> paths = _dirPaths.values.toList();
    for (var path in paths) {
      if (!Directory(path).existsSync()) {
        final pathDir = Directory(path);
        pathDir.create(recursive: true);
      }
    }
  }

  
  void marked(PdfFile pdfFile) {
    if (_markedPdfFile.any((file) => file.title == pdfFile.title)) {
      _markedPdfFile.removeWhere((file) => file.title == pdfFile.title);
    } else {
      _markedPdfFile.add(pdfFile);
    }

    notifyListeners();
  }

  bool isMarked(String title) {
    return _markedPdfFile.any((file) => file.title == title);
  }

  void clearMarked() {
    this._markedPdfFile.clear();
  }

  void initPdfLists() async {
    var paths = _dirPaths;
    paths.forEach((listName, path) async {
      final List<PdfFile> pdfFiles = <PdfFile>[];
      final dir = Directory(path);

      if (await dir.exists()) {
        await for (var file in dir.list(recursive: true)) {
          if (file.path.contains('.pdf')) {
            final title = file.path.split('/').last;
            final path = file.path;
            final size = getFileSize(path);
            pdfFiles.add(PdfFile(title, "", size, path));
          }
        }
      }
      _pdfListDirs[listName] = PdfListDir(title: listName, pdfFiles: pdfFiles);
    });
  }

  void setMarkingState(bool value) {
    isMarking = value;
    clearMarked();
    notifyListeners();
  }

  Future<bool> checkPermission() async {
    // var status = await Permission.storage.request();
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
        // final directory = await getExternalStorageDirectory();
        final directory = Directory('/storage/emulated/0/Documents');
        if (directory != null) {
          if (!await directory.exists()) {
            await directory.create(recursive: true);
          }
        }
        return true;
    }
    return false;
  }
}

