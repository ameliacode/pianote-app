import 'package:pianote/models/pdf_file_model.dart';

class PdfListDir {
  final String title;
  final List<PdfFile> pdfFiles;

  PdfListDir({required this.title, required this.pdfFiles});

  void add(PdfFile file) {
    this.pdfFiles.add(file);
  }

  void remove(PdfFile pdfFile) {
    this.pdfFiles.removeWhere((file) => file.title == pdfFile.title);
  }

  void update(PdfFile pdfFile, int index) {
    this.pdfFiles.removeAt(index);
    this.pdfFiles.insert(index, pdfFile);
  }
}