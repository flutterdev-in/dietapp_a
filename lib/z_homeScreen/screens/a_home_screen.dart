import 'package:dietapp_a/y_Drawer/main_drawer.dart';
import 'package:dietapp_a/z_homeScreen/controllers/welcome_controller.dart';
import 'package:dietapp_a/z_homeScreen/widgets/a_drawe_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  WelcomeController wc = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: GFDrawer(
            child: MainDrawer(),
          ),
          appBar: AppBar(
            title: const Text("DietApp"),
            actions: [
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(Icons.logout))
            ],
            leading: const DrawerIcon(),
          )),
    );
  }
}
