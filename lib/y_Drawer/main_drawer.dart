import 'package:dietapp_a/assets/assets.dart';
import 'package:dietapp_a/y_Drawer/widgets/profile_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          const DrawerProfileContainer(),
          const Divider(
            color: Colors.black,
          ),
          SizedBox(height: Get.height * 0.6),
          Container(
            height: 50,
            child: SvgPicture.asset(Assets().googleIcon),
          ),
          ListTile(
            tileColor: Colors.black26,
            trailing: Icon(Icons.settings),
            title: const Text(
              "Settings",
              textScaleFactor: 1.2,
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 1.3,
          ),
          ListTile(
              tileColor: Colors.black26,
              trailing: Icon(Icons.logout_outlined),
              title: Text(
                "Logout",
                textScaleFactor: 1.2,
              ),
              onTap: () {
                // Get.find<WelcomeController>().logout();
              }),
        ],
      ),
    );
  }
}
