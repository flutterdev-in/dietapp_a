import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  String? chatDocID;
  List chatMembers = [];
  String? lastChatSentBy;
  String? lastChatRecdBy;
  Timestamp? lastChatTime;
  String? lastChatType;
  String lastChatString;
  Map<String, dynamic>? lastChatMap;
  bool isChatRestricted = false;
  List<Map<String, dynamic>>? chatRestrictionMaps;

  ChatRoomModel({
    required this.chatDocID,
    required this.chatMembers,
    required this.lastChatSentBy,
    required this.lastChatRecdBy,
    required this.lastChatTime,
    required this.lastChatType,
    this.lastChatString = "String",
    this.lastChatMap,
    this.isChatRestricted = false,
    this.chatRestrictionMaps,
    
  });

  Map<String, dynamic> toMap() {
    return {
      "chatDocID": chatDocID,
      "chatMembers": chatMembers,
      "lastChatSentBy": lastChatSentBy,
      "lastChatRecdBy": lastChatRecdBy,
      "lastChatTime": lastChatTime,
      "lastChatType": lastChatType,
      "lastChatString": lastChatString,
      "lastChatMap": lastChatMap,
      "isChatRestricted": isChatRestricted,
      "chatRestrictionMaps": chatRestrictionMaps,
    };
  }

  factory ChatRoomModel.fromMap(Map chatRoomModelMap) {
    return ChatRoomModel(
      chatDocID: chatRoomModelMap["chatDocID"] ?? "",
      chatMembers: chatRoomModelMap["chatMembers"] ?? [],
      lastChatSentBy: chatRoomModelMap["lastChatSentBy"] ?? "",
      lastChatRecdBy: chatRoomModelMap["lastChatRecdBy"] ?? "",
      lastChatTime: chatRoomModelMap["lastChatTime"],
      lastChatType: chatRoomModelMap["lastChatType"] ?? "String",
      lastChatString: chatRoomModelMap["lastChatString"] ?? "",
      lastChatMap: chatRoomModelMap["lastChatMap"],
      isChatRestricted: chatRoomModelMap["isChatRestricted"] ?? false,
      chatRestrictionMaps: chatRoomModelMap["chatRestrictionMaps"],
    );
  }
}
