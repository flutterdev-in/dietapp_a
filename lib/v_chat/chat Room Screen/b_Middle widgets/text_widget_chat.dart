import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';
import 'package:flutter/material.dart';

class TextWidgetChatMiddle extends StatelessWidget {
  final MessageModel mm;

  const TextWidgetChatMiddle({Key? key, required this.mm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSentByMe = mm.chatSentBy == userUID;
    return Container(
      decoration: BoxDecoration(
        color: isSentByMe ? secondaryColor : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: isSentByMe ? const Radius.circular(10) : Radius.zero,
          topRight: const Radius.circular(10),
          bottomLeft: const Radius.circular(10),
          bottomRight: isSentByMe ? Radius.zero : const Radius.circular(10),
        ),
      ),
      constraints: BoxConstraints(
        minHeight: 35,
        minWidth: 100,
        maxWidth: MediaQuery.of(context).size.width * 4 / 5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(mm.chatString ?? ""),
      ),
    );
  }
}
