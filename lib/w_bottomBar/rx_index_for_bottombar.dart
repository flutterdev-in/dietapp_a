import 'package:dietapp_a/Diet%20plans/a_Main%20Screen/Appbar%20actions/appbar_actions_widget.dart';
import 'package:dietapp_a/Diet%20plans/a_Main%20Screen/main_screen_dp.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/_foods_folder_main_screen.dart';
import 'package:dietapp_a/v_chat/chat%20People%20View/chat_people_listview.dart';
import 'package:dietapp_a/v_chat/chat%20Search/chat_search_button.dart';
import 'package:dietapp_a/z_homeScreen/b_home_screen_body.dart';
import 'package:dietapp_a/z_homeScreen/timing_view_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Rx<int> bottomBarindex = 0.obs;

List<Widget> listMainContainers = [
  Container(
    child:
        // tableCalendar()
        // const TimingViewHomeScreen(),
    const HomeScreenBody(),
  ),
  const ChatPeopleListview(),
  const MainScreenDP(),
  // YoutubeTestScreen(),
  const MyFoodsCollectionView(),
];

List<Widget> listAppBarButtons = [
  Container(
    child: const Text("Home"),
  ),
  chatSearchButton,
  const AppbarActionsWidget(),
  Container(
    child: const Text("Pro"),
  ),
];

Widget curretContainer() {
  // return listMainContainers[0];
  return Obx(() => listMainContainers[bottomBarindex.value]);
}

Widget currentAppBarButton() {
  return Obx(() => listAppBarButtons[bottomBarindex.value]);
}
