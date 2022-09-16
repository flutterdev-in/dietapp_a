import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/fc_back_button_function.dart';
import 'package:dietapp_a/w_bottomBar/_bottom_navigation_bar.dart';
import 'package:dietapp_a/x_FCM/fcm_functions.dart';
import 'package:dietapp_a/z_homeScreen/app%20States/user_activity_update.dart';
import 'package:dietapp_a/z_homeScreen/controllers/welcome_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'z_homeScreen/app States/hive_indexes_update.dart';

class ManinScreenManager extends StatefulWidget {
  const ManinScreenManager({Key? key}) : super(key: key);

  @override
  State<ManinScreenManager> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ManinScreenManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    FCMfunctions.setupInteractedMessage();
    FCMfunctions.onMessage();
    FCMfunctions.checkFCMtoken();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    await userActivityUpdate(state);
    await hiveIndexesUpdate(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    super.dispose();
  }

  WelcomeController wc = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (bottomBarindex.value == 3) {
          fcBackButtonFunction();
        } else if (bottomBarindex.value != 0) {
          bottomNavController.jumpToTab(0);
        }
        return false;
      },
      child: const Scaffold(
        body: BottomBarWithBody(),
      ),
    );
  }
}
