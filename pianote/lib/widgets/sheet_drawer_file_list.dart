import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:pianote/widgets/pdf_tile.dart';
import 'package:pianote/providers/history_provider.dart';
import 'package:pianote/models/pdf_file.dart';
import 'package:pianote/models/pdf_manager.dart';
import 'package:provider/provider.dart';
import 'package:file_manager/file_manager.dart';

class SheetDrawerFileList extends StatelessWidget {
  final String name;
  final String query;
  //final HistoryProvider recentProvider;
  const SheetDrawerFileList({Key? key, required this.name, required this.query,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PdfList(dirName: name, query:query, ),
    );
  }
}

class PdfList extends StatelessWidget {
  final String dirName;
  final String query;
  final FileManagerController controller = FileManagerController();
  // final HistoryProvider recentProvider;
  PdfList({Key? key, required this.dirName, required this.query, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Consumer<PdfManager>(
          builder: (context, pdfManager, _) => PdfListContainer(
            dirName: dirName,
            query: query,
            pdfManager: pdfManager,
            //recentProvider: recentProvider,
          ),
        ),
      ],
    );
  }
}

class PdfListContainer extends StatelessWidget with GetItMixin{
  PdfListContainer({Key? key, 
    required this.dirName, 
    required this.query,
    required this.pdfManager,
    //required this.recentProvider
  }) : super(key: key);

  final String dirName;
  final String query;
  //final HistoryProvider recentProvider;
  final pdfManager;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: FutureBuilder<List<PdfFile>>(
        future: query.isNotEmpty ? pdfManager.getPdfs(dirName, query:query) : pdfManager.getPdfs(dirName),
        builder: (context, AsyncSnapshot<List<PdfFile>> snapshot) {
          if (snapshot.hasData) {
            final itemLength = snapshot.data!.length;
            return ListView.builder(
              itemCount: itemLength,
              itemBuilder: (context, index) {
                return PdfTile(
                  pdfFile: snapshot.data![index],
                  isLastElement: index == itemLength - 1,
                  onTap: () {
                    //recentProvider.addRecentFile(snapshot.data![index].path);
                    get<HistoryProvider>().setRecentFile(snapshot.data![index].path);
                    get<HistoryProvider>().addRecentFile(snapshot.data![index].path);
                  },
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
