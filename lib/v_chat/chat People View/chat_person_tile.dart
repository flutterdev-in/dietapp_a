import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/hive%20Boxes/boxes.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/_chat_room_screen.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/x_customWidgets/stream_builder_functions.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class ChatRoomTile extends StatelessWidget {
  final ChatRoomModel crm;
  const ChatRoomTile(
    this.crm, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(uss.users)
            .doc(crm.chatPersonUID)
            .snapshots(),
        builder: (c, AsyncSnapshot<DocumentSnapshot> d) {
          var data = docStreamReturn(c, d, widType: "tile");
          if (data is Map) {
            UserWelcomeModel uwm = UserWelcomeModel.fromMap(data);
            return GFListTile(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(0),
              title: Text(
                uwm.displayName,
              ),
              avatar: GFAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  uwm.photoURL!,
                ),
                size: GFSize.SMALL,
              ),
              subTitle: (crm.lastChatModel?.chatString != null)
                  ? Text(crm.lastChatModel!.chatString!)
                  : null,
              onTap: () async {
                apc.currentActiveDayDR.value =
                    admos.activeDayDR(DateTime.now(), userUID);
                Get.to(() {
                  var isChat = boxIndexes.get(crm.chatPersonUID) ?? false;
                  if (isChat == false) {
                    return ChatRoomScreen(crm, isChat: false);
                  } else {
                    return ChatRoomScreen(crm);
                  }
                }, opaque: false, transition: Transition.leftToRightWithFade);
              },
            );
          }
          return data;
        });
  }
}
