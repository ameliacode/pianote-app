import 'package:flutter/material.dart';
import 'package:tabbed_view/tabbed_view.dart';

class SheetTabView extends StatefulWidget {
  const SheetTabView({Key? key}) : super(key: key);
  
  @override
  State<SheetTabView> createState() => _SheetTabViewState();
}

class _SheetTabViewState extends State<SheetTabView> {
  late TabbedViewController _controller;

  @override 
  void initState(){
    super.initState();
    List<TabData> tabs = [];

    tabs.add(TabData(
      text: 'example',
      content: Text("example 1")  
    ));

    _controller = TabbedViewController(tabs);
  }

  @override
  Widget build(BuildContext context) {
    TabbedView tabbedView = TabbedView(controller: _controller);
     return TabbedViewTheme(
      child: tabbedView, 
      data: TabbedViewThemeData.mobile(
        accentColor: Colors.blueAccent
     ));
  }
}

