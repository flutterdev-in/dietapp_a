// ChatScreenController chatSC = ChatScreenController();
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ChatScreenVariables csv = ChatScreenVariables();

class ChatScreenVariables {
  final selectedList =
      RxList<QueryDocumentSnapshot<Map<String, dynamic>>>([]).obs;
  final Rx<String> chatType = chatTS.stringOnly.obs;
  final Rx<String> tcText = "".obs;
  final FocusNode focusNode = FocusNode();
  final replyMessageModel = dummyMM.obs;
}

final MessageModel dummyMM = MessageModel(
    chatSentBy: userUID, chatRecdBy: userUID, senderSentTime: DateTime.now());
