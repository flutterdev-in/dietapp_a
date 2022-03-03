import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/global%20Strings/global_strings.dart';
import 'package:dietapp_a/hive%20Boxes/hive_boxes.dart';
import 'package:dietapp_a/settings/a_Profile/_profile_view.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/userData/uid.dart';
import 'package:dietapp_a/v_chat/chat%20Room/chat_room_model.dart';
import 'package:dietapp_a/v_chat/chat%20Room/chat_room_objects.dart';
import 'package:dietapp_a/x_customWidgets/colors.dart';
import 'package:dietapp_a/x_customWidgets/stream_builder_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Widget chatRoomAppBar(var chatPersonUID) {
  Widget details() {
    if (chatPersonUID == uid) {
      return Text(
        "My Chats",
        style: TextStyle(color: Colors.white),
      );
    } else {
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(chatPersonUID)
              .snapshots(),
          builder: (c, AsyncSnapshot<DocumentSnapshot> d) {
            var data = docStreamReturn(c, d, widType: "tile");
            if (data is Map) {
              UserWelcomeModel uwm = UserWelcomeModel.fromMap(data);
              return Row(
                children: [
                  GFAvatar(
                    maxRadius: 16,
                    size: GFSize.SMALL,
                    backgroundImage: NetworkImage(uwm.photoURL!),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    uwm.displayName ?? "",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              );
            }
            return Container();
          });
    }
  }

  return Container(
    height: 50,
    color: CLR().primary,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              MdiIcons.arrowLeft,
              color: Colors.white,
            )),
        details(),
      ],
    ),
  );
}
