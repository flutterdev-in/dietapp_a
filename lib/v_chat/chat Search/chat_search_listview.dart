import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/_chat_room_screen.dart';
import 'package:dietapp_a/v_chat/chat%20Search/chat_search_textfield.dart';
import 'package:dietapp_a/v_chat/constants/chat_const_variables.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';

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
              .collection(uss.users)
              .where(uss.userID, isEqualTo: chatSearchString.value)
              .limit(1),
          // .orderBy(crs.lastChatTime, descending: true),
          itemBuilder: (context, snapshot) {
            Map<String, dynamic> userMap = snapshot.data();
            UserWelcomeModel uwm = UserWelcomeModel.fromMap(userMap);

            return ListTile(
                title: Text(uwm.displayName),
                subtitle: Text(uwm.userID),
                leading: GFAvatar(
                  size: GFSize.SMALL,
                  backgroundImage: NetworkImage(uwm.photoURL!),
                ),
                onTap: () async {
                  var crm =await crs.chatRoomModelFromChatPersonUID(uwm.firebaseUID);
                  

                    Get.to(() => ChatRoomScreen(crm), opaque: false);
                  
                });
          },
        ));
  }
}
