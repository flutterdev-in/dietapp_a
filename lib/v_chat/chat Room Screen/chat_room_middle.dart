import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/global%20Strings/global_strings.dart';
import 'package:dietapp_a/v_chat/messageFiles/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class ChatRoomMiddle extends StatelessWidget {
  late final String docID;
  ChatRoomMiddle(this.docID, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.black26,
        child: FirestoreListView<Map<String, dynamic>>(
          reverse: true,
          shrinkWrap: true,
          query: FirebaseFirestore.instance
              .collection(gs.chatRooms)
              .doc(docID)
              .collection(gs.messages)
              .orderBy(gs.chatTime, descending: true),

          // .orderBy(gs.lastChatTime, descending: true),
          itemBuilder: (context, snapshot) {
            Map<String, dynamic> messageMap = snapshot.data();
            MessageModel crm = MessageModel.fromMap(messageMap);

            return Container(
              child: Text(crm.toMap().toString()),
            );
          },
        ),
      ),
    );
  }
}
