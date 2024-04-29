import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:unicons/unicons.dart';
// import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:animated_search_bar/animated_search_bar.dart';

class CategoryFileScreen extends StatefulWidget {
  const CategoryFileScreen({Key? key}) : super(key: key);
  @override
  State<CategoryFileScreen> createState() => _FileManagerState();
}

class _FileManagerState extends State<CategoryFileScreen> {
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
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                    closeIcon: Icon(UniconsLine.times, color: Colors.grey, size: 20.0),
                    searchIcon: Icon(UniconsLine.search, color: Colors.blueAccent, size: 20.0),
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
                  //child: SearchBar(
                  //  padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(7, 0, 5, 2.5)),
                  //  backgroundColor: MaterialStatePropertyAll(Colors.grey[100]),
                  //  leading: const Icon(UniconsLine.search, color: Colors.black26, size: 15.0),
                  //  elevation:  MaterialStatePropertyAll(0.0),
                  //  constraints: BoxConstraints(maxHeight: 30.0),
                  //  side: MaterialStatePropertyAll(BorderSide(width: 1.0, color: Colors.black12)),
                  //  hintText: "악보 및 작곡가명을 입력하세요",
                  //    hintStyle: MaterialStatePropertyAll(TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500, color: Colors.grey[500])),
                  //),
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
                GFIconButton(
                  iconSize: 15.0,
                  size: GFSize.SMALL,
                  padding: EdgeInsets.all(5.0),
                  color: Colors.white,
                  icon: Icon(UniconsLine.filter, color: Colors.blueAccent,), 
                  onPressed: () => {},
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.grey[100],
              child: Text("hello"), 
            ),
          ),
        ],
      ),
    );
  }
}
