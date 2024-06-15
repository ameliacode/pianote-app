import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:pianote/providers/history_provider.dart';
import 'package:pianote/widgets/sheet_viewer.dart';

//for single view state management
class SheetTab extends StatefulWidget with GetItStatefulWidgetMixin {
  @override
  State<SheetTab> createState() => _SheetTabState();
}

class _SheetTabState extends State<SheetTab> with GetItStateMixin {
  late var _future;

  @override
  void initState() {
    super.initState();
    _future = get<HistoryProvider>().getRecentFile();
  }

  @override
  Widget build(BuildContext context) {
    _future = watchOnly((HistoryProvider h) => h.getRecentFile());
    return FutureBuilder(
      future: _future, 
      builder: (context, snapshot) {
        String data = snapshot.data?.toString() ?? '';
        print('sheet_tab $data');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No file found.'));
        } else { return data!.length != 0 && data.isNotEmpty ? 
            SheetViewer(filePath: data) :
            Container(
            alignment: Alignment.center,
            child: Text(
              "🎼 파일이 없습니다. 악보 파일을 열어주세요! 😥",
              style: TextStyle(
                fontWeight: FontWeight.w600,),
            ),
          );  
        } 
    });
  }
}