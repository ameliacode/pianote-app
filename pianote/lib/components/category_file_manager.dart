import 'package:flutter/material.dart';
import 'package:pianote/components/pdf_file_tile.dart';
import 'package:pianote/models/pdf_file_model.dart';
import 'package:pianote/models/pdf_manager_model.dart';
import 'package:provider/provider.dart';

class CategoryPdfManager extends StatelessWidget {
  final String name;

  const CategoryPdfManager({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: PdfList(dirName: name),
    );
  } 
}

class PdfList extends StatelessWidget {
  final dirName;
  const PdfList({Key ? key, this.dirName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Consumer<PdfManager>(
          builder: (context, pdfManager, _) => PdfListContainer(
            dirName: dirName, 
            pdfManager: pdfManager
          )),
        Consumer<PdfManager>(builder: (context, pdfManager, _) {
          if (pdfManager.isMarking) {
            return Text("working");
          } else {
            return Text("Not working");
          }
        })
      ],
    );
  }
}

class PdfListContainer extends StatelessWidget {
  const PdfListContainer(
    {Key? key, required this.dirName, required this.pdfManager}
  ) : super(key: key);

  final String dirName;
  final pdfManager;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<PdfFile>>(
        future: pdfManager.getPdfs(dirName),
        builder: (context, AsyncSnapshot<List<PdfFile>> snapshot) {
          if (snapshot.hasData) {
            final itemLength = snapshot.data!.length;
            return ListView.builder(
              itemCount: itemLength,
              itemBuilder: (context, index) {
                return PdfTile(
                  pdfFile: snapshot.data![index], 
                  isLastElement: index == itemLength - 1,
                );
              });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }), 
    );
  }
}