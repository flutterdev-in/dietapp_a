import 'package:dietapp_a/Diet%20plans/a_Main%20Screen/plan_screen.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/hive%20Boxes/box_names.dart';
import 'package:dietapp_a/hive%20Boxes/boxes.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/_foods_folder_main_screen.dart';
import 'package:dietapp_a/settings/settings_screen.dart';
import 'package:dietapp_a/v_chat/chat%20People%20View/chat_screen.dart';
import 'package:dietapp_a/z_homeScreen/_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

Rx<int> bottomBarindex = 0.obs;
PersistentTabController bottomNavController = PersistentTabController();

class BottomBarWithBody extends StatelessWidget {
  const BottomBarWithBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bottomNavController.index = boxIndexes.get(boxKeyNames.bottomBarindex) ?? 0;
    if (bottomNavController.index == 4) {
      bottomNavController.index = 0;
    }
    return PersistentTabView(
      context,
      controller: bottomNavController,
      onItemSelected: (index) async {
        bottomBarindex.value = index;
      },
      navBarStyle: NavBarStyle.simple,
      screens: const [
        HomeScreen(),
        ChatScreen(),
        PlanScreen(),
        FoodCollectionScreen(),
        SettingsScreen(),
      ],
      decoration: NavBarDecoration(
          border: Border.all(color: Colors.black26, width: 0.45)),
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(MdiIcons.home),
          inactiveIcon: const Icon(MdiIcons.homeOutline),
          title: ("Home"),
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(MdiIcons.chatProcessing),
          inactiveIcon: const Icon(MdiIcons.chatProcessingOutline),
          title: ("Diet Chat"),
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(MdiIcons.clipboardText),
          inactiveIcon: const Icon(MdiIcons.clipboardTextOutline),
          title: ("Diet Plan"),
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(MdiIcons.folderOpen),
          inactiveIcon: const Icon(MdiIcons.folderOpenOutline),
          title: ("Collection"),
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(MdiIcons.accountCog),
          inactiveIcon: const Icon(MdiIcons.accountCogOutline),
          title: ("Settings"),
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ],
    );
  }
}
