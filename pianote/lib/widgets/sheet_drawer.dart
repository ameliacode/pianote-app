import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pianote/widgets/sheet_drawer_download.dart';
import 'package:pianote/widgets/sheet_drawer_files.dart';
import 'package:unicons/unicons.dart';
import 'package:pianote/providers/history_provider.dart';

class SheetDrawer extends StatefulWidget {
  const SheetDrawer({Key? key, required this.recentProvider}) : super(key: key);
  final HistoryProvider recentProvider;

  @override
  State<SheetDrawer> createState() => _SheetDrawerState();
}

class _SheetDrawerState extends State<SheetDrawer> with SingleTickerProviderStateMixin {
  late TabController tabController;
  static const List<Tab> drawerTabs = <Tab>[
    Tab(
      text: "모든 악보",
    ),
    Tab(
      text: "다운로드",
    ),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: drawerTabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      child: Scaffold(
        appBar: GFAppBar(
          leading: GFIconButton(
            padding: EdgeInsets.all(0.0),
            color: Colors.white,
            icon: Icon(UniconsLine.angle_left, color: Colors.blueAccent),
            onPressed:  () => Navigator.of(context).pop(),
            ),
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: GFSegmentTabs(
            length: drawerTabs.length,
            tabs: drawerTabs,
            tabBarColor: Colors.grey[50],
            labelColor: Colors.blueAccent,
            labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 11.0),
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.grey[600],
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 11.0),
            indicator: BoxDecoration(
              color:Colors.white,
              border: Border.all(color: Colors.blueAccent, width:1.0),
              borderRadius: BorderRadius.circular(4.0)
            ),
            indicatorWeight: 2.0,
            border: Border.all(color: Colors.black12, width: 1.0),
            borderRadius: BorderRadius.circular(4.0),
            tabController: tabController,
          )
        ),
        body: GFTabBarView(
          controller: tabController,
          children: <Widget>[
            SheetDrawerFiles(recentProvider: widget.recentProvider,),
            SheetDrawerDownload(),
          ],)
      )
    );
  }
}