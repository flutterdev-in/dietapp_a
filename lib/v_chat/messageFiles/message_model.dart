import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? docID;
  String chatSentBy;
  String chatRecdBy;
  Timestamp chatTime;
  bool isChatUploaded;
  String chatType;
  String? chatString;
  Map<String, dynamic>? chatMap;

  MessageModel({
    this.docID,
    required this.chatSentBy,
    required this.chatRecdBy,
    required this.chatTime,
    required this.chatType,
    required this.isChatUploaded,
    this.chatString,
    this.chatMap,
  });

  Map<String, dynamic> toMap() {
    return {
      "docID": docID,
      "chatSentBy": chatSentBy,
      "chatRecdBy": chatRecdBy,
      "chatTime": chatTime,
      "chatType": chatType,
      "isChatUploaded": isChatUploaded,
      "chatString": chatString,
      "chatMap": chatMap,
    };
  }

  factory MessageModel.fromMap(Map messageMap) {
    return MessageModel(
      docID: messageMap["docID"],
      chatSentBy: messageMap["chatSentBy"],
      chatRecdBy: messageMap["chatRecdBy"],
      chatTime: messageMap["chatTime"] ?? DateTime.now,
      chatType: messageMap["chatType"] ?? "String",
      isChatUploaded: messageMap["isChatUploaded"] ?? false,
      chatString: messageMap["chatString"],
      chatMap: messageMap["chatMap"],
    );
  }
}
