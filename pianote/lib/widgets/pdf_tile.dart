import 'package:flutter/material.dart';
import 'package:pianote/models/pdf_file.dart';
import 'package:pianote/models/pdf_manager.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class PdfTile extends StatelessWidget {
  final PdfFile pdfFile;
  final bool isLastElement;
  final VoidCallback? onTap;

  const PdfTile({Key? key, required this.pdfFile, required this.isLastElement, required this.onTap}
  ) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    final pdfManager = Provider.of<PdfManager>(context, listen: false);
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: isLastElement ? 
          EdgeInsets.only(bottom: 0)
          : EdgeInsets.only(bottom: 2.5),
        height: MediaQuery.of(context).size.height * .07,
        width: MediaQuery.of(context).size.width * .97,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * .17,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    pdfFile.title.replaceAll('.pdf', ''),
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis
                  ),
                  Text(
                    pdfFile.size,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100)
                  )
                ],
              )
            ),
            // pdfManager.isMarking 
            //   ? Icon(
            //     UniconsLine.check,
            //     color: pdfManager.isMarked(pdfFile.title) 
            //       ? Colors.deepPurple : Colors.grey,
            //   ) : SizedBox(
            //     width: 10,
            //   )
          ],
        )
      ),
      onTap: onTap
      //() {
        // if (pdfManager.isMarking) {
        //   final pdfManager = Provider.of<PdfManager>(context, listen:false);
        //   pdfManager.marked(pdfFile);
        // } else {
        //   Text("hello");
        // }
        //},
    );
  }
}