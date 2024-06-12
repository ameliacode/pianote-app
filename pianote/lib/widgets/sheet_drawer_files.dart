import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pianote/widgets/popup_button.dart';
import 'package:pianote/widgets/sheet_drawer_file_list.dart';
import 'package:unicons/unicons.dart';
import 'package:pianote/providers/history_provider.dart';
import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';

class SheetDrawerFiles extends StatefulWidget {
  //final HistoryProvider recentProvider;
  //const SheetDrawerFiles({Key? key, required this.recentProvider}) : super(key: key);

  @override
  State<SheetDrawerFiles> createState() => _FileManagerState();
}

class _FileManagerState extends State<SheetDrawerFiles> {
  late String searchValue;
  late TextEditingController textController;
  late CustomPopupMenuController editController;
  late CustomPopupMenuController utilController;

  @override
  void initState() {
    super.initState();
    searchValue = '';
    textController = TextEditingController();
    editController = CustomPopupMenuController();
    utilController = CustomPopupMenuController();
  }

  @override
  void dispose() {
    textController.dispose();
    editController.dispose();
    utilController.dispose();
    super.dispose();
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
            padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
            child: Row(
              children: [
                Expanded(
                  child: AnimatedSearchBar(
                    cursorColor: Colors.grey,
                    searchDecoration: InputDecoration(
                      prefixText:null,
                      filled: true,
                      fillColor: Colors.grey[100],
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
                  ),
                ),
                SizedBox(
                  width: 32.0,
                  child: GFButton(
                    text: "선택",
                    size: GFSize.SMALL,
                    color: Colors.white,
                    padding: EdgeInsets.all(5.0),
                    textStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 11.0, color: Colors.blueAccent),
                    onPressed: () => {},
                  ),
                ),
                SizedBox(width:5.0),
                SizedBox(
                  width: 32.0,
                  child: FilterPopupButton(menuController: utilController,)
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.grey[100],
              child: SheetDrawerFileList(
                name: 'Files', 
                query: searchValue,
                //recentProvider: widget.recentProvider,
              ), 
            ),
          ),
        ],
      ),
    );
  }
}
