import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/global%20Strings/global_strings.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/userData/uid.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/_chat_room_screen.dart';
import 'package:dietapp_a/v_chat/chat%20Search/chat_search_textfield.dart';
import 'package:dietapp_a/v_chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class ChatSearchListview extends StatelessWidget {
  const ChatSearchListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => FirestoreListView<Map<String, dynamic>>(
          shrinkWrap: true,
          query: FirebaseFirestore.instance
              .collection(gs.users)
              .where(gs.userID, isLessThanOrEqualTo: chatSearchString.value),
          // .orderBy(gs.lastChatTime, descending: true),
          itemBuilder: (context, snapshot) {
            Map<String, dynamic> userMap = snapshot.data();
            UserWelcomeModel uwm = UserWelcomeModel.fromMap(userMap);

            return ListTile(
              title: Text(uwm.displayName ?? ""),
              subtitle: Text(uwm.userID ?? ""),
              leading: GFAvatar(
                size: GFSize.SMALL,
                backgroundImage: NetworkImage(uwm.photoURL!),
              ),
              onTap: () async {
                List<String> chatDocIDList = [uwm.firebaseUID ?? uid, uid];

                chatDocIDList.sort();
                cc.thisChatDocID.value = chatDocIDList[0] + "_" + chatDocIDList[1];

                Map<String, dynamic> chatIDMap = {
                  gs.chatMembers: chatDocIDList,
                  gs.chatDocID: cc.thisChatDocID.value,
                  uid: {"isThisChatOpen": true}
                };
                await FirebaseFirestore.instance
                    .collection(gs.chatRooms)
                    .doc(cc.thisChatDocID.value)
                    .set(chatIDMap, SetOptions(merge: true))
                    .then((value) {
                  
                  return Get.to(ChatRoomScreen(),
                      );
                });
              },
            );
          },
        ));
  }
}
