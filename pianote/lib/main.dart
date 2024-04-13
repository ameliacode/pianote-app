import 'package:flutter/material.dart';
import 'screens/viewer.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pdfrx example',
      home: MainPage()
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
      body: PdfView()
    );
  }
}
