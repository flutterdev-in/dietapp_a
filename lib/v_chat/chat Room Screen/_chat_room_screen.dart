import 'package:dietapp_a/v_chat/chat%20Room%20Screen/chat_room_bottom.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/chat_room_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/chat_room_top.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String chatPersonUID = Get.arguments[0];
    String docID = Get.arguments[1];

    return SafeArea(
        child: Scaffold(
      body: Container(
        // color: Colors.blue.shade100,
        child: Column(
          children: [
            chatRoomAppBar(chatPersonUID),
            ChatRoomMiddle(docID),
            ChatRoomBottom(chatPersonUID, docID),
          ],
        ),
      ),
    ));
  }
}
