import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/global%20Strings/global_strings.dart';
import 'package:dietapp_a/hive%20Boxes/hive_boxes.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';

import 'package:dietapp_a/v_chat/chat%20Room%20Screen/_chat_room_screen.dart';
import 'package:dietapp_a/v_chat/constants/chat_const_variables.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';
import 'package:dietapp_a/x_customWidgets/stream_builder_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatRoomTile extends StatelessWidget {
  late final Map<String, dynamic> chatRoomMap;

  ChatRoomTile({
    required this.chatRoomMap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(uss.users)
            .doc(chatPersonUID.value)
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
                  return const Icon(MdiIcons.dotsCircle, color: Colors.green);
                }
              } else {
                return const Icon(MdiIcons.circleMedium, color: Colors.yellow);
              }
            }

            return GFListTile(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(0),
              title: Text(
                uwm.displayName,
              ),
              avatar: GFAvatar(
                backgroundImage: NetworkImage(uwm.photoURL!),
                size: GFSize.SMALL,
              ),
              subTitle: Text(
                crm.lastChatType == crs.string ? crm.lastChatString : "",
              ),
              icon: greenDot(),
              onTap: () async {
                thisChatDocID.value = crm.chatDocID;
                await FirebaseFirestore.instance
                    .collection(gs.chatRooms)
                    .doc(thisChatDocID.value)
                    .update({
                  userUID: {crs.isThisChatOpen: true}
                });
                Get.to(() => const ChatRoomScreen(),
                    opaque: false, transition: Transition.leftToRightWithFade);
              },
            );
          }
          return data;
        });
  }
}
