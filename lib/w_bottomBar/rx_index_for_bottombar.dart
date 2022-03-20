import 'package:dietapp_a/Diet%20plans/a_Main%20Screen/Appbar%20actions/appbar_actions_widget.dart';
import 'package:dietapp_a/Diet%20plans/a_Main%20Screen/Appbar%20actions/diet_plan_screen_menu_button.dart';
import 'package:dietapp_a/Diet%20plans/a_Main%20Screen/main_screen_dp.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/_foods_folder_main_screen.dart';
import 'package:dietapp_a/my%20foods/screens/youtube/youtube_test_screen.dart';
import 'package:dietapp_a/v_chat/chat%20People%20View/chat_people_listview.dart';
import 'package:dietapp_a/v_chat/chat%20Search/chat_search_button.dart';
import 'package:dietapp_a/z_homeScreen/widgets/a_drawe_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Rx<int> bottomBarindex = 0.obs;

List<Widget> listMainContainers = [
  Container(
    child: Text("Home"),
  ),
  ChatPeopleListview(),
  MainScreenDP(),
  // YoutubeTestScreen(),
  MyFoodsCollectionView(),
];

List<Widget> listAppBarButtons = [
  Container(
    child: Text("Home"),
  ),
  chatSearchButton,
  AppbarActionsWidget(),
  Container(
    child: Text("Pro"),
  ),
];

Widget curretContainer() {
  // return listMainContainers[0];
  return Obx(() => listMainContainers[bottomBarindex.value]);
}

Widget currentAppBarButton() {
  return Obx(() => listAppBarButtons[bottomBarindex.value]);
}
