import 'package:flutter/material.dart';
import 'package:pianote/models/pdf_manager_model.dart';
import 'package:pianote/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  var status = await PdfManager().checkPermission();
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

