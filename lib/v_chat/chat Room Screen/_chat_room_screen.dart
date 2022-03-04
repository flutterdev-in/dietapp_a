import 'package:dietapp_a/v_chat/chat%20Room%20Screen/chat_room_bottom.dart';
import 'package:dietapp_a/v_chat/controllers/chat_room_controller.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/chat_room_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/chat_room_top.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ChatScreenController());
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          chatRoomAppBar(),
          ChatRoomMiddle(),
          const ChatRoomBottom(),
        ],
      ),
    ));
  }
}
