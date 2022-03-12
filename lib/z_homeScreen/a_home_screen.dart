import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/fc_back_button_function.dart';
import 'package:dietapp_a/w_bottomBar/_bottom_navigation_bar.dart';
import 'package:dietapp_a/w_bottomBar/rx_index_for_bottombar.dart';
import 'package:dietapp_a/y_Drawer/main_drawer.dart';
import 'package:dietapp_a/z_homeScreen/app%20States/app_states.dart';
import 'package:dietapp_a/z_homeScreen/controllers/welcome_controller.dart';
import 'package:dietapp_a/z_homeScreen/widgets/a_drawe_icon.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:getwidget/getwidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    await fireActivity(state);
    super.didChangeAppLifecycleState(state);
  }

  WelcomeController wc = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (bottomBarindex.value == 3) {
          fcBackButtonFunction();
        }
        return false;
      },
      child: Scaffold(
        drawer: GFDrawer(
          child: MainDrawer(),
        ),
        appBar: AppBar(
          title: const Text("DietApp"),
          actions: [
            currentAppBarButton(),
          ],
          leading: const DrawerIcon(),
        ),
        body: curretContainer(),
        bottomNavigationBar: const BottomNavigationBarW(),
      ),
    );
  }
}
