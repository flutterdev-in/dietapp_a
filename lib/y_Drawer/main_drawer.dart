import 'package:flutter/material.dart';
import 'package:get/get.dart';
      
class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          // profileContainer(),
          Divider(
            color: Colors.black,
          ),
          SizedBox(height: Get.height * 0.6),
          ListTile(
            tileColor: Colors.black26,
            trailing: Icon(Icons.settings),
            title: Text(
              "Settings",
              textScaleFactor: 1.2,
            ),
            onTap: () {},
          ),
          SizedBox(
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
