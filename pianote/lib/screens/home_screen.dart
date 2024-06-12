import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pianote/widgets/sheet_drawer.dart';
import 'package:pianote/widgets/sheet_tabview.dart';
import 'package:flutter/services.dart';
import 'package:pianote/models/pdf_manager.dart';
import 'package:pianote/providers/history_provider.dart';
import 'package:pianote/widgets/sheet_tab.dart';
import 'package:pianote/widgets/sheet_viewer.dart';
import 'package:tabbed_view/tabbed_view.dart';
import 'package:unicons/unicons.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget with GetItStatefulWidgetMixin{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with GetItStateMixin{ 
  bool _showAppBar = true;

  void initState() {
    super.initState();
    Provider.of<PdfManager>(context, listen: false).initPdfLists();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ));
    
    // recentProvider is for tabview
    //final recentProvider =  Provider.of<HistoryProvider>(context, listen: false);
    String title = get<HistoryProvider>().getRecentFile().toString().replaceAll('.pdf','');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      //drawer: SheetDrawer(recentProvider: recentProvider,),
      drawer: SheetDrawer(),
      appBar: _showAppBar ? PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child:  GFAppBar(
        title: Text(title, ),
        centerTitle: true,
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
      )) : null,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            _showAppBar = !_showAppBar;
          });
        },
        child: SheetTabView()
        // child: SheetTabView(recentProvider: get<HistoryProvider>())
        // child: Padding(
        //   padding: EdgeInsets.only(top: _showAppBar ? 0 : 30),
        //   child: SafeArea(
        //     child: SheetTab()
        //   )
        // )
      )
    );
  }
}