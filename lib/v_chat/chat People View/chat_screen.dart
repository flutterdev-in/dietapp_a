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
      body: Column(
        children: [
          userTileW(),
          Expanded(
            child: FirestoreListView<Map<String, dynamic>>(
              shrinkWrap: true,
              query: FirebaseFirestore.instance
                  .collection(crs.chatRooms)
                  .where(crs.chatMembers, arrayContains: userUID)
                  .orderBy(crs.lastChatTime, descending: true),
              itemBuilder: (context, snapshot) {
                var crm = ChatRoomModel.fromMap(snapshot.data());
                if (crm.chatPersonUID == userUID) {
                  return const SizedBox();
                } else {
                  return ChatRoomTile(crm);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget userTileW() {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: crs.chatDRf([userUID, userUID]).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.data() != null) {
            var crm = ChatRoomModel.fromMap(snapshot.data!.data()!);
            return ChatRoomTile(crm);
          }
          return const SizedBox();
        });
  }
}
