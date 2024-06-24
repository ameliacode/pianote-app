import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pianote/widgets/custom_appbar.dart';
import 'package:pianote/widgets/sheet_drawer.dart';
import 'package:pianote/widgets/sheet_tabview.dart';
import 'package:flutter/services.dart';
import 'package:pianote/models/pdf_manager.dart';
import 'package:pianote/providers/history_provider.dart';
import 'package:pianote/widgets/sheet_tab.dart';
import 'package:unicons/unicons.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget with GetItStatefulWidgetMixin{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with GetItStateMixin, SingleTickerProviderStateMixin{ 
  bool _showAppBar = true;
  late final AnimationController _controller;

  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
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
    final title = get<HistoryProvider>().getRecentFile();

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      drawer: SheetDrawer(),
      appBar: CustomAppBar(
        child: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child:  GFAppBar(
        title: FutureBuilder<String>(
          future: title, 
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (data == null || data!.length == 0) {
              return const Center(child: Text(''));
           } else {
           final _title = data.split('\/').last.replaceAll('.pdf','');
            return Text(_title, 
            style: TextStyle(color: Colors.grey[700], fontSize: 12.5));
            }
          }
        ) ,
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
        )), 
        controller: _controller, 
        visible: _showAppBar),
      body: Stack(
        children: [
          IgnorePointer( //riverpod state로 전부 바꾸기
            child: SafeArea(
             child: SheetTab()
           ),),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
              _showAppBar = !_showAppBar;
              });
              print("app bar visible");
            }
          ),
        ],
      )
    );
  }
}