import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/x_customWidgets/stream_builder_functions.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:flutter/material.dart';

class DrawerProfileContainer extends StatelessWidget {
  const DrawerProfileContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FireRef().userDocStrem,
        builder: (c, AsyncSnapshot<DocumentSnapshot> d) {
          var data = SB().docStream(c, d, widType: "tile");
          if (data is Map) {
            UserWelcomeModel uwm = UserWelcomeModel.fromMap(data);

            return ListTile(
              tileColor: Colors.black87,
              title: Text(
                uwm.displayName ?? "",
                textScaleFactor: 1.2,
                style: const TextStyle(color: Colors.white),
              ),
              leading: CircleAvatar(
                foregroundImage: NetworkImage(uwm.photoURL!),
              ),
              subtitle: Text(
                uwm.userID ?? "",
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Get.to(() => UserProfileView());
              },
            );
          }
          return data;
        });
  }
}
