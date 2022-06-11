import 'package:dietapp_a/v_chat/chat%20Search/chat_search_listview.dart';
import 'package:dietapp_a/v_chat/chat%20Search/chat_search_textfield.dart';
import 'package:flutter/material.dart';

class ChatSearchScreen extends StatelessWidget {
  const ChatSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [chatSearchFieldRow, const ChatSearchListview()],
        ),
      ),
    );
  }
}
