import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:pianote/widgets/sheet_viewer.dart';
import 'package:pianote/providers/history_provider.dart';
import 'package:tabbed_view/tabbed_view.dart';
// import 'package:provider/provider.dart';

class SheetTabView extends StatefulWidget with GetItStatefulWidgetMixin{
  // final HistoryProvider recentProvider;
  // const SheetTabView({Key? key, required this.recentProvider}) : super(key: key);

  @override
  State<SheetTabView> createState() => _SheetTabViewState();
}

class _SheetTabViewState extends State<SheetTabView> with GetItStateMixin {
  late TabbedViewController _controller;
  late List<String> recentFiles;

  @override
  void initState() {
    super.initState();
    _controller = TabbedViewController([]);
    // _initializeTabs(widget.recentProvider.recentFiles);
    recentFiles = get<HistoryProvider>().getRecentFiles();
    _initializeTabs(recentFiles);
  }

 

  void _initializeTabs(List<String> recentFiles) {
    print(recentFiles.length);
    final tabs = recentFiles.map((filePath) {
      return TabData(
        value: filePath,
        text: filePath.split('/').last.replaceAll('.pdf', ''),
        content: SheetViewer(filePath: filePath),
      );
    }).toList();
    _controller = TabbedViewController(tabs);
  }

  // @override
  // void didUpdateWidget(SheetTabView oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.recentProvider != widget.recentProvider) {
  //     _initializeTabs(widget.recentProvider.recentFiles);
  //   }
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // final recentFiles = Provider.of<HistoryProvider>(context).recentFiles;
  //   // final recentFiles = widget.recentProvider.recentFiles;
  //    recentFiles = watchOnly((HistoryProvider h) => h.recentFiles);
  //   _initializeTabs(recentFiles);
  // }

  @override
  Widget build(BuildContext context) {
  recentFiles = watchOnly((HistoryProvider h) => h.recentFiles);
      return TabbedViewTheme(
          data: TabbedViewThemeData.mobile(
          accentColor: Colors.blueAccent,
        ),
        child: recentFiles.length != 0 ?  
          TabbedView(
            controller: _controller,
            onTabClose: (tabIndex, tabData) async {
              await get<HistoryProvider>().removeRecentFile(tabData.value);
            },
          ) :
          Container(
            alignment: Alignment.center,
            child: Text(
              "🎼 파일이 없습니다. 악보 파일을 열어주세요! 😥",
              style: TextStyle(
                fontWeight: FontWeight.w600,),
            ),
          )
      );
    }
}

// PREVIOUS VER.
// return Consumer<HistoryProvider>(
//   builder: (context, pdfFileProvider, _) {
