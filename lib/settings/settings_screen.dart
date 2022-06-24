import 'package:dietapp_a/Google%20Drive/image_pick.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/hive%20Boxes/boxes.dart';
import 'package:dietapp_a/settings/a_Profile/basic%20info%20screen/basic_info_edit_screen.dart';
import 'package:dietapp_a/settings/user%20info%20screen/a_profile_first.dart';
import 'package:dietapp_a/x_FCM/fcm_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'b_default timings/default_timings_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            const ProfileFirst(),
            const SizedBox(height: 10),
            basic(),
            defaultFoodTimings(),
            logout(),
            const ImagePickerW(),
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

  Widget defaultFoodTimings() {
    return GFListTile(
      avatar: const Icon(
        MdiIcons.wrenchClock,
      ),
      titleText: "Default Food Timings",
      onTap: () {
        Get.to(() => const DefaultTimingsSettingsScreen());
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
          await removeFcmToken();
          await GoogleSignIn().disconnect();
          await FirebaseAuth.instance.signOut();
        });
  }

  Future<void> removeFcmToken() async {
    await userDR.update({
      "$unIndexed.${fcmVariables.fcmToken}": null,
    });
    await boxServices.put(fcmVariables.fcmToken, null);
  }
}
