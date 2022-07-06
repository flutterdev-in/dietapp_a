import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/hive%20Boxes/boxes.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/_chat_room_screen.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';
import 'package:dietapp_a/x_customWidgets/stream_builder_functions.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

class ChatRoomTile extends StatelessWidget {
  final ChatRoomModel crm;
  bool _haveUnseen = true;
  ChatRoomTile(
    this.crm, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(uwmos.users)
            .doc(crm.chatPersonUID)
            .snapshots(),
        builder: (c, AsyncSnapshot<DocumentSnapshot> d) {
          var data = docStreamReturn(c, d, widType: "tile");
          if (data is Map) {
            UserWelcomeModel uwm = UserWelcomeModel.fromMap(data);
            return ListTile(
              title: Text(
                uwm.displayName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: GFAvatar(
                backgroundColor: Colors.black12,
                backgroundImage: CachedNetworkImageProvider(
                  uwm.photoURL!,
                ),
                size: GFSize.SMALL,
              ),
              trailing: unseenCount(),
              subtitle: (crm.lastChatModel != null)
                  ? Text(
                      (crm.lastChatModel!.chatSentBy == userUID
                              ? "\u{2B06} "
                              : "\u{2B07} ") +
                          crm.lastChatModel!.fcmModel.fcmBody,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black54),
                    )
                  : null,
              onTap: () async {
                apc.currentActiveDayDR.value =
                    admos.activeDayDR(DateTime.now(), userUID);
                Get.to(() {
                  var isChat = boxIndexes.get(crm.chatPersonUID) ?? false;

                  if (isChat == false && _haveUnseen == false) {
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

  Widget unseenCount() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: crm.chatDR
            .collection(crs.chats)
            .where(mmos.chatRecdBy, isEqualTo: userUID)
            .where(mmos.recieverSeenTime, isNull: true)
            .limit(6)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return GFAvatar(
              maxRadius: snapshot.data!.docs.length > 5 ? 12 : 10,
              backgroundColor: Colors.green.shade200,
              child: Text(
                snapshot.data!.docs.length > 5
                    ? "5+"
                    : snapshot.data!.docs.length.toString(),
              ),
            );
          } else {
            _haveUnseen = false;
          }
          return titleTime();
        });
  }

  Widget titleTime() {
    if (crm.lastChatModel?.senderSentTime != null) {
      String ampm = DateFormat("a")
          .format(crm.lastChatModel!.senderSentTime)
          .toLowerCase();
      String chatDayTime =
          DateFormat("dd MMM").format(crm.lastChatModel!.senderSentTime) + ampm;
      //
      String today = DateFormat("dd MMM").format(DateTime.now());
      String chatDay =
          DateFormat("dd MMM").format(crm.lastChatModel!.senderSentTime);

      if (today == chatDay) {
        chatDayTime =
            DateFormat("h:mm").format(crm.lastChatModel!.senderSentTime) + ampm;
      }
      return Text(chatDayTime, textScaleFactor: 0.95);
    }
    return const SizedBox();
  }
}
