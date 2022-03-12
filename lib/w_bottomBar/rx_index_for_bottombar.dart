import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/_foods_folder_main_screen.dart';
import 'package:dietapp_a/my%20foods/screens/youtube/youtube_test_screen.dart';
import 'package:dietapp_a/v_chat/chat%20People%20View/chat_people_listview.dart';
import 'package:dietapp_a/v_chat/chat%20Search/chat_search_button.dart';
import 'package:dietapp_a/y_Firebase/manage%20Firestore/sub%20Names/sub_names.dart';
import 'package:dietapp_a/z_homeScreen/widgets/a_drawe_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Rx<int> bottomBarindex = 0.obs;

List<Widget> listMainContainers = [
  Container(
    child: Text("Home"),
  ),
  ChatPeopleListview(),
  YoutubeTestScreen(),
  MyFoodsCollectionView(),
];

List<Widget> listAppBarButtons = [
  Container(
    child: Text("Home"),
  ),
  chatSearchButton,
  Container(
    child: Text("Search"),
  ),
  Container(
    child: Text("Profile"),
  ),
  AppBar(
    title: const Text("DietApp"),
    actions: [
      currentAppBarButton(),
    ],
    leading: const DrawerIcon(),
  ),
];

List<Widget?> listAppBars = [
  AppBar(
    title: const Text("DietApp"),
    actions: [
      currentAppBarButton(),
    ],
    leading: const DrawerIcon(),
  ),
  AppBar(
    title: const Text("DietApp"),
    actions: [
      currentAppBarButton(),
    ],
    leading: const DrawerIcon(),
  ),
  null,
  null,
];

Widget curretContainer() {
  // return listMainContainers[0];
  return Obx(() => listMainContainers[bottomBarindex.value]);
}

Widget currentAppBarButton() {
  return Obx(() => listAppBarButtons[bottomBarindex.value]);
}
