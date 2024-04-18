import 'package:flutter/material.dart';
import 'package:pianote/screens/home_screen.dart';
import 'components/sheet_viewer.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

void main() {
  runApp(
    const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen()
    );
  }
}
