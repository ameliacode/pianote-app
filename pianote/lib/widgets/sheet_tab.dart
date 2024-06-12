import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:pianote/providers/history_provider.dart';
import 'package:pianote/widgets/sheet_viewer.dart';

//for single view state management
class SheetTab extends StatelessWidget with GetItMixin {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: watchOnly((HistoryProvider h) => h.getRecentFile()),
      builder: (context, snapshot) {
        return snapshot.data?.length != 0 ? 
        SheetViewer(filePath: snapshot.data.toString()) :
        Container(
        alignment: Alignment.center,
        child: Text(
          "🎼 파일이 없습니다. 악보 파일을 열어주세요! 😥",
          style: TextStyle(
            fontWeight: FontWeight.w600,),
        ),
      );
      }
    );
  }
}