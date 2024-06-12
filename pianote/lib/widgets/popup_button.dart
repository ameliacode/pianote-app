import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:unicons/unicons.dart';

class ItemModel {
  String title;
  IconData icon;
  ItemModel(this.title, this.icon);
}

class PopupButton extends StatefulWidget {
  final Container button;
  final CustomPopupMenuController menuController;
  final List<ItemModel> menuItems;
  const PopupButton({Key? key, required this.button, required this.menuController, required this.menuItems}) : super(key: key);
  @override
 _PopupButtonState createState() => _PopupButtonState();
}

class _PopupButtonState extends State<PopupButton> {
  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      arrowColor: Colors.white,
      child: widget.button,
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.white,
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: 
                widget.menuItems.map(
                (item) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    widget.menuController.hideMenu();
                  },
                  child: Container(
                    height: 30,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          item.icon,
                          size: 15,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: Container(
                          padding:EdgeInsets.symmetric(vertical: 1.0),
                          child: Text(
                            item.title,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
          ),
        ),
      ),
    ),
    pressType: PressType.singleClick,
    verticalMargin: -10,
    controller: widget.menuController,
    );
  }
}

// buttons for each in drawer tab

// filter button for sorting and viewing(later)

class EditPopupButton extends StatefulWidget {
  final CustomPopupMenuController menuController;
  const EditPopupButton({Key? key, required this.menuController,}) : super(key: key);
  @override
 _EditPopupButtonState createState() => _EditPopupButtonState();
}

class _EditPopupButtonState extends State<EditPopupButton> {
  late List<ItemModel> menuItems;

  @override
  void initState() {
    super.initState();
    menuItems = [
      ItemModel('수정', UniconsLine.edit_alt),
      ItemModel('삭제', UniconsLine.trash)
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return PopupButton(
      button:Container(
        child: Text('선택', 
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 11.0, color: Colors.blueAccent),),
        color: Colors.white,
        padding: EdgeInsets.all(4.0),
      ),  
      menuController: widget.menuController,
      menuItems: menuItems
    );
  }
}

// editing button 
class FilterPopupButton extends StatefulWidget {
  final CustomPopupMenuController menuController;
  const FilterPopupButton({Key? key, required this.menuController,}) : super(key: key);
  @override
  _FilterPopupButtonState createState() => _FilterPopupButtonState();
}

class _FilterPopupButtonState extends State<FilterPopupButton> {
  late List<ItemModel> menuItems;

  @override
  void initState() {
    super.initState();
    menuItems = [
      ItemModel('제목', UniconsLine.sorting),
      ItemModel('아티스트', UniconsLine.sorting),
    ];
  }
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopupButton(
      button: Container(
        child:  Icon(
          UniconsLine.ellipsis_h, color: Colors.blueAccent,
          size: 15,
        ), 
        padding: EdgeInsets.all(5.0),
        color: Colors.white,
      ),
      menuController: widget.menuController, 
      menuItems: menuItems
    );
  }
}
