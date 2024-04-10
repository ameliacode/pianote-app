import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:snappy_list_view/snappy_list_view.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, orientation, screenType) {    
        return MaterialApp(
      title: 'Pdfrx example',
      home: MainPage());
      }
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final showLeftPane = ValueNotifier<bool>(false);
  var needCoverPage = true;
  var isRightToLeftReadingOrder = false;
  // final documentRef = ValueNotifier<PdfDocumentRef?>(null);
  // final controller = PdfViewerController();
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("viewer"),
        toolbarHeight: 30.0,
       // titleTextStyle: TextStyle(fontSize: 20),
      ),
      body: PdfDocumentViewBuilder.asset(
        'assets/sample.pdf',
        builder: (context, document) => SnappyListView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          itemSnapping: true,
          itemCount: document?.pages.length ?? 0,
          itemBuilder: (context, index) {
            index *= 2;
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(0),
              height: 100.0.h,
              color: Colors.white,
              child: Row(
                children: 
                [ SizedBox(
                  width: 50.0.w,
                  height: 100.0.h,
                  child: PdfPageView(
                    decoration: BoxDecoration(
                      boxShadow: null
                    ) ,
                    document: document,
                    pageNumber: index + 1,
                    alignment: Alignment.centerRight,
                  ),
                ),
                  SizedBox(
                    width: 50.0.w,
                    height: 100.0.h,
                    child: PdfPageView(
                      decoration: BoxDecoration(
                        boxShadow: null
                      ),
                      document: document,
                      pageNumber: index + 2,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ],
              )
            );
          },
        ),
      ),
    );
  }
}
