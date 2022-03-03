
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String chatSentBy;
  String chatRecdBy;
  Timestamp chatTime;
  String chatType;
  String? chatString;
  Map<String, dynamic>? chatMap;

  MessageModel({
    required this.chatSentBy,
    required this.chatRecdBy,
    required this.chatTime,
    required this.chatType,
    this.chatString,
    this.chatMap,
  });

  Map<String, dynamic> toMap() {
    return {
      "chatSentBy": chatSentBy,
      "chatRecdBy": chatRecdBy,
      "chatTime": chatTime,
      "chatType":chatType,
      "chatString": chatString,
      "chatMap": chatMap,
    };
  }

  factory MessageModel.fromMap(Map messageMap) {
    return MessageModel(
      chatSentBy: messageMap["chatSentBy"],
      chatRecdBy: messageMap["chatRecdBy"],
      chatTime: messageMap["chatTime"]??DateTime.now,
      chatType: messageMap["chatType"]??"String",
      chatString: messageMap["chatString"],
      chatMap: messageMap["chatMap"],
    );
  }
}

