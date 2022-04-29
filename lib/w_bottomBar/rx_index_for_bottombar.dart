import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:dietapp_a/Diet%20plans/a_Main%20Screen/Appbar%20actions/appbar_actions_widget.dart';
import 'package:dietapp_a/Diet%20plans/a_Main%20Screen/main_screen_dp.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/_foods_folder_main_screen.dart';
import 'package:dietapp_a/v_chat/chat%20People%20View/chat_people_listview.dart';
import 'package:dietapp_a/v_chat/chat%20Search/chat_search_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../y_Active diet/controllers/days_controller.dart';

Rx<int> bottomBarindex = 0.obs;

List<Widget> listMainContainers = [
  Container(child: tableCalendar()
      // const Text("Home"),
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

Widget tableCalendar() {
  DateTime today = DateTime.now();

  return CalendarAgenda(
      // fullCalendar: false,
      fullCalendarScroll: FullCalendarScroll.horizontal,
      initialDate: today,
      fullCalendarDay: WeekDay.long,
      selectedDayPosition: SelectedDayPosition.center,
      firstDate: dc.dateDiffer(today, false, ymd: "y", differ: 1),
      lastDate: dc.dateDiffer(today, true, ymd: "y", differ: 1),
      onDateSelected: () {});
}
