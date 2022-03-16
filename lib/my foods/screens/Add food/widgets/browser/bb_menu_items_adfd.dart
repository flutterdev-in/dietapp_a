import 'package:dietapp_a/my%20foods/screens/Add%20food/widgets/browser/bba_menu_buttons.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/widgets/browser/c_fav_web_pages.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuItemsWebBrowser extends StatelessWidget {
  const MenuItemsWebBrowser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: const EdgeInsets.all(10.0),
      color: Colors.black87,
      child: Icon(MdiIcons.dotsVertical, color: Colors.black),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: MenuButtons(),
          ),
          PopupMenuItem(
            child: FavWebPages(),
          ),
        ];
      },
    );
  }

}
