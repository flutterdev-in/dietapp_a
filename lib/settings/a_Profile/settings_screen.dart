import 'package:dietapp_a/settings/a_Profile/basic%20info%20screen/basic_info_edit_screen.dart';
import 'package:dietapp_a/settings/a_Profile/user%20info%20screen/a_profile_first.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            const ProfileFirst(),
            const SizedBox(height: 10),
            basic(),
            logout(),
          ],
        ));
  }

  Widget basic() {
    return GFListTile(
      avatar: const Icon(
        Icons.manage_accounts,
      ),
      titleText: "Basic Information",
      subTitleText: "Gender,Age,Height,Weight,Activity",
      onTap: () {
        Get.to(() => BasicInfoEditScreen());
      },
    );
  }

  Widget logout() {
    return GFListTile(
        avatar: const Icon(
          MdiIcons.logout,
        ),
        titleText: "Logout",
        onTap: () async {
          await GoogleSignIn().disconnect();
          await FirebaseAuth.instance.signOut();
        });
  }
}
