import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pianote/components/sheet_drawer.dart';
import 'package:pianote/components/sheet_viewer.dart';
import 'package:flutter/services.dart';
import 'package:unicons/unicons.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: SheetDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: GFAppBar(
        backgroundColor: Colors.white,
        elevation: 0.7,
        leading: Builder( 
          builder: (context) => GFIconButton(
            padding: EdgeInsets.all(2),
            size: GFSize.SMALL,
            color: Colors.white,
            icon: Icon(
              UniconsLine.bars , color:Colors.grey[700]),
              onPressed:(){
              Scaffold.of(context).openDrawer(); // openEndDrawer();
            }
          )
        )
      )),
      body: SafeArea(child: SheetView())
    );
  }
}