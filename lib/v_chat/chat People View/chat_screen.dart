import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/chat%20People%20View/chat_person_tile.dart';
import 'package:dietapp_a/v_chat/chat%20Search/chat_search_button.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diet Chat"),
        actions: [
          chatSearchButton,
        ],
      ),
      body: Container(
        color: Colors.white,
        child: FirestoreListView<Map<String, dynamic>>(
          shrinkWrap: true,
          query: FirebaseFirestore.instance
              .collection(crs.chatRooms)
              .where(crs.chatMembers, arrayContains: userUID),
          // .orderBy(gs.lastChatTime, descending: true),
          itemBuilder: (context, snapshot) {
            
            var crm = ChatRoomModel.fromMap(snapshot.data());
            return ChatRoomTile(crm);
          },
        ),
      ),
    );
  }
}
