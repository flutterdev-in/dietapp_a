import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';

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
      mms.docID: docID,
      mms.chatSentBy: chatSentBy,
      mms.chatRecdBy: chatRecdBy,
      mms.chatTime: chatTime,
      mms.chatType: chatType,
      mms.isChatUploaded: isChatUploaded,
      mms.chatString: chatString,
      mms.chatMap: chatMap,
    };
  }

  factory MessageModel.fromMap(Map messageMap) {
    return MessageModel(
      docID: messageMap[mms.docID],
      chatSentBy: messageMap[mms.chatSentBy],
      chatRecdBy: messageMap[mms.chatRecdBy],
      chatTime: messageMap[mms.chatTime] ?? DateTime.now,
      chatType: messageMap[mms.chatType] ?? "String",
      isChatUploaded: messageMap[mms.isChatUploaded] ?? false,
      chatString: messageMap[mms.chatString],
      chatMap: messageMap[mms.chatMap],
    );
  }
}


