import 'package:dietapp_a/my%20foods/screens/Add%20food/widgets/app_search_listview.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/widgets/count_button_adfd.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/widgets/textfield_adfd.dart';

import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddFoodScreen extends StatelessWidget {
  AddFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: appBarW(context),
        body: Column(
          children: [
            Expanded(child: AppSearchListview()),
          ],
        ),
      ),
    );
  }

  appBarW(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 5,
      title: Row(
        children: [
          SizedBox(width: 10),
          Expanded(child: const TextFieldAdfd(), flex: 5),
          SizedBox(width: 4),
         CountButtonAdfdW(),
        ],
      ),
    );
  }

  Widget floatingButtonW() {
    return FloatingActionButton(
      onPressed: () {},
      child: Text("Add"),
      backgroundColor: Colors.green.shade500,
    );
  }

  Widget textFieldPrefix() {
    return PopupMenuButton(
      child: Icon(
        MdiIcons.menu,
        color: Colors.white,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(child: Text("DietApp")),
          PopupMenuItem(child: Text("Youtube")),
          PopupMenuItem(child: Text("TimesFood")),
          PopupMenuItem(child: Text("Google")),
        ];
      },
    );
  }
}