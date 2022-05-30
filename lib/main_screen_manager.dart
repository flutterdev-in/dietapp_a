import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/fc_back_button_function.dart';
import 'package:dietapp_a/w_bottomBar/_bottom_navigation_bar.dart';
import 'package:dietapp_a/z_homeScreen/app%20States/app_states.dart';
import 'package:dietapp_a/z_homeScreen/controllers/welcome_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
