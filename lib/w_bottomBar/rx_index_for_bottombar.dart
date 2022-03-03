import 'package:dietapp_a/v_chat/chat%20People%20View/chat_people_listview.dart';
import 'package:dietapp_a/v_chat/chat%20Search/chat_search_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Rx<int> bottomBarindex = 0.obs;

List<Widget> listMainContainers = [
  Container(
    child: Text("Home"),
  ),
  const ChatPeopleListview(),
  Container(
    child: Text("Search"),
  ),
  Container(
    child: Text("Profile"),
  ),
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
];

Widget curretContainer() {
  // return listMainContainers[0];
  return Obx(() => listMainContainers[bottomBarindex.value]);
}

Widget currentAppBarButton() {
  return Obx(() => listAppBarButtons[bottomBarindex.value]);
}
