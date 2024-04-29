import 'package:flutter/material.dart';
import 'package:pianote/models/pdf_manager_model.dart';
import 'package:pianote/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const Pianote());
}

class Pianote extends StatelessWidget {
  const Pianote({Key? key}) : super(key: key);

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
