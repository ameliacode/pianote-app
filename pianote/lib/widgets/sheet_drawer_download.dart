import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:pianote/providers/history_provider.dart';
import 'package:pianote/widgets/search_recent.dart';
import 'package:unicons/unicons.dart';
import 'package:animated_search_bar/animated_search_bar.dart';


class SheetDrawerDownload extends StatefulWidget with GetItStatefulWidgetMixin{
  //final HistoryProvider recentProvider;
  //const SheetDrawerDownload({Key? key, required this.recentProvider}) : super(key: key);
  @override
  State<SheetDrawerDownload> createState() => _FileManagerState();
}

class _FileManagerState extends State<SheetDrawerDownload> with GetItStateMixin {
  late String searchValue;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    searchValue = '';
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            height: 46,
            padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
            child: Row(
              children: [
                Expanded(
                  child: AnimatedSearchBar(
                    cursorColor: Colors.grey,
                    searchDecoration: InputDecoration(
                      prefixText:null,
                      filled: true,
                      fillColor: Colors.grey [100],
                      focusColor: Colors.grey,
                      alignLabelWithHint: false,
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.all(5.0)
                    ),
                    height:30.0,
                    closeIcon: Icon(UniconsLine.times, color: Colors.grey, size: 17.5),
                    searchIcon: Icon(UniconsLine.search, color: Colors.blueAccent, size: 17.5),
                    label: "악보 및 작곡가명을 입력하세요.",
                    labelStyle: TextStyle(fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.normal),
                    searchStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
                    onChanged: (value) {
                      debugPrint("value on Change");
                      setState(() {
                        searchValue = value;
                      });
                    },
                    onFieldSubmitted: (value) async {
                      //await widget.recentProvider.addRecentSearch(value);
                      //print(widget.recentProvider.recentSearch);
                      await get<HistoryProvider>().addRecentSearch(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.grey[100],
              child: SearchRecent(searchValue:searchValue), 
            ),
          ),
        ],
      ),
    );
  }
}
