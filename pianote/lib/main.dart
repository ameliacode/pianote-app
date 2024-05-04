import 'package:flutter/material.dart';
import 'package:pianote/models/pdf_manager_model.dart';
import 'package:pianote/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  var status = await checkPermission();
  listFiles();
  if (status) {
    PdfManager.createDirs(); 
  }
  runApp(const Pianote());
}

class Pianote extends StatefulWidget {
  const Pianote({Key? key}) : super(key: key);
  @override
  State<Pianote> createState() => _PianoteState();
}

class _PianoteState extends State<Pianote>{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PdfManager(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Pretendard",
        ),
        home: HomeScreen()
      )
    );
  }
}

Future<bool> checkPermission() async {
  var status = await Permission.storage.request();
  if (status.isGranted) {
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
      }
      return true;
  }
  return false;
}

void listFiles() async {
  //Directory documentsDirectory = await getApplicationDocumentsDirectory();
  Directory? documentsDirectory = await getExternalStorageDirectory();

  List<FileSystemEntity>? files = documentsDirectory?.listSync(recursive: true);
  if (files != null){
    for (FileSystemEntity file in files) {
      print(file.path);
    }
  }
}

