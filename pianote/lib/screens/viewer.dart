import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
// import 'package:snappy_list_view/snappy_list_view.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class PdfView extends StatefulWidget {
  const PdfView({Key? key}) : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  // final documentRef = ValueNotifier<PdfDocumentRef?>(null);
  
  // List<PdfDocument> data = [];
  int _focusedIndex = 0;
  GlobalKey<ScrollSnapListState> sslkey = GlobalKey();

  void _onItemFocus(int index){
    setState(() {
      _focusedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSizer( 
      builder:(context, orientation, screenType) {
      return PdfDocumentViewBuilder.asset(
        'assets/sample.pdf',
        builder: (context, document) => ScrollSnapList(
          key: sslkey,
          listViewKey: widget.key,
          scrollDirection: Axis.horizontal,
          scrollPhysics: PageScrollPhysics(),
          onItemFocus: _onItemFocus,
          itemSize: 100.0.w,
          itemCount: orientation == Orientation.portrait ?
             document?.pages.length ?? 0 : (document?.pages.length ?? -1) ~/ 2 + 1,
          itemBuilder: (context, index) {
            if (orientation != Orientation.portrait) {
              index *= 2;
            }
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(0),
              height: 100.0.h,
              width: 100.0.w,
              color: Colors.white,
              child: PdfContainer(
                document: document, 
                index: index,
                pageCount: orientation == Orientation.portrait ? 1:2
              )
            );
          }
        )
      );
      }
    );
    }
  }


class PdfContainer extends StatelessWidget {
  final PdfDocument? document;
  final int index;
  final int pageCount;

  const PdfContainer({
    Key? key,
    required this.document,
    required this.index,
    required this.pageCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(pageCount, (idx) {
        return SizedBox(
          width: (100 / pageCount).w,
          height: 100.h,
          child: PdfPageView(
            decoration: BoxDecoration(
              boxShadow: null
            ) ,
            document: document,
            pageNumber: index + idx + 1,
            alignment: pageCount == 1 ? Alignment.center : 
                (index + idx + 1) % 2 == 0 ?  Alignment.centerLeft : Alignment.centerRight,
          ),
        );
      })
    );
  }
}
