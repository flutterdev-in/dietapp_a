import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/global%20Strings/global_strings.dart';
import 'package:dietapp_a/hive%20Boxes/hive_boxes.dart';
import 'package:dietapp_a/settings/a_Profile/_profile_view.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/userData/uid.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/_chat_room_screen.dart';
import 'package:dietapp_a/v_chat/chat%20Room/chat_room_model.dart';
import 'package:dietapp_a/v_chat/chat%20Room/chat_room_objects.dart';
import 'package:dietapp_a/x_customWidgets/stream_builder_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatRoomTile extends StatelessWidget {
  late final String chatPersonUID;
  late final Map<String, dynamic> chatRoomMap;
  ChatRoomTile({
    Key? key,
    required this.chatPersonUID,
    required this.chatRoomMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(chatPersonUID)
            .snapshots(),
        builder: (c, AsyncSnapshot<DocumentSnapshot> d) {
          var data = docStreamReturn(c, d, widType: "tile");
          if (data is Map) {
            UserWelcomeModel uwm = UserWelcomeModel.fromMap(data);
            ChatRoomModel crm = ChatRoomModel.fromMap(chatRoomMap);
            Widget? greenDot() {
              if (crm.lastChatTime != null &&
                  chatBox.get(gs.lastChatTimeWhenOpen) != null) {
                if (crm.lastChatTime.toString() !=
                    chatBox.get(gs.lastChatTimeWhenOpen)) {
                  return Icon(MdiIcons.dotsCircle, color: Colors.green);
                }
              } else {
                return Icon(MdiIcons.circleMedium, color: Colors.yellow);
              }
            }

            if (chatPersonUID == uid) {
              return Text("");
            } else {
              return GFListTile(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(0),
                title: Text(
                  uwm.displayName ?? "",
                ),
                avatar: GFAvatar(
                  backgroundImage: NetworkImage(uwm.photoURL!),
                ),
                subTitle: Text(
                  crm.lastChatType == "String" ? crm.lastChatString : "",
                ),
                icon: greenDot(),
                onTap: () {
                  Get.to(() {
                    return ChatRoomScreen();
                  }, arguments: [chatPersonUID, crm.docID]);
                },
              );
            }
          }
          return data;
        });
  }
}
