import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/chat%20People%20View/chat_person_tile.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class ChatPeopleListview extends StatelessWidget {
  const ChatPeopleListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FirestoreListView<Map<String, dynamic>>(
        shrinkWrap: true,
        query: FirebaseFirestore.instance
            .collection(crs.chatRooms)
            .where(crs.chatMembers, arrayContains: userUID),
        // .orderBy(gs.lastChatTime, descending: true),
        itemBuilder: (context, snapshot) {
          Map<String, dynamic> chatRoomMap = snapshot.data();
          return ChatRoomTile(
            chatRoomMap: chatRoomMap,
          );
        },
      ),
    );
  }
}
