import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/global%20Strings/global_strings.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/chat%20People%20View/chat_person_tile.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';

import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';


class ChatPeopleListview extends StatelessWidget {
  const ChatPeopleListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        chatBodyStreamWidget(),
      ]),
    );
  }
}



Widget chatBodyStreamWidget() {
  return FirestoreListView<Map<String, dynamic>>(
    shrinkWrap: true,
    query: FirebaseFirestore.instance
        .collection(gs.chatRooms)
        .where(gs.chatMembers, arrayContains: userUID),
    // .orderBy(gs.lastChatTime, descending: true),
    itemBuilder: (context, snapshot) {
      Map<String, dynamic> chatRoomMap = snapshot.data();
      ChatRoomModel crm = ChatRoomModel.fromMap(chatRoomMap);
      String chatPersonUID =
          crm.chatMembers[0] == userUID ? crm.chatMembers[1] : crm.chatMembers[0];
      return ChatRoomTile(
        chatPersonUID: chatPersonUID,
        chatRoomMap: chatRoomMap,
      );
    },
  );
}
