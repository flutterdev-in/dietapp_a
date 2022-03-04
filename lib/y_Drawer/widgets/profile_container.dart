import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/settings/a_Profile/_profile_view.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/x_customWidgets/colors.dart';
import 'package:dietapp_a/x_customWidgets/stream_builder_functions.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getwidget/getwidget.dart';

class DrawerProfileContainer extends StatelessWidget {
  const DrawerProfileContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: userDS,
        builder: (c, AsyncSnapshot<DocumentSnapshot> d) {
          var data = docStreamReturn(c, d, widType: "tile");
          if (data is Map) {
            UserWelcomeModel uwm = UserWelcomeModel.fromMap(data);
            return GFListTile(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(0),
              color: CLR().primary,
              title: Text(
                uwm.displayName ?? "",
                textScaleFactor: 1.3,
                style: const TextStyle(color: Colors.white),
              ),
              avatar: GFAvatar(
                backgroundImage: NetworkImage(uwm.photoURL!),
              ),
              subTitle: Text(
                "\n${uwm.userID}",
                style: const TextStyle(color: Colors.white, height: 0.7),
              ),
              onTap: () {
                Get.to(() => const ProfileView());
              },
            );
          }
          return data;
        });
  }
}
