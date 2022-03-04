import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';

class ChatRoomModel {
  String chatDocID;
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
    this.lastChatString = "string",
    this.lastChatMap,
    this.isChatRestricted = false,
    this.chatRestrictionMaps,
  });

  Map<String, dynamic> toMap() {
    return {
      crs.chatDocID: chatDocID,
      crs.chatMembers: chatMembers,
      crs.lastChatSentBy: lastChatSentBy,
      crs.lastChatRecdBy: lastChatRecdBy,
      crs.lastChatTime: lastChatTime,
      crs.lastChatType: lastChatType,
      crs.lastChatString: lastChatString,
      crs.lastChatMap: lastChatMap,
      crs.isChatRestricted: isChatRestricted,
      crs.chatRestrictionMaps: chatRestrictionMaps,
    };
  }

  factory ChatRoomModel.fromMap(Map chatRoomModelMap) {
    return ChatRoomModel(
      chatDocID: chatRoomModelMap[crs.chatDocID] ?? "",
      chatMembers: chatRoomModelMap[crs.chatMembers] ?? [],
      lastChatSentBy: chatRoomModelMap[crs.lastChatSentBy] ?? "",
      lastChatRecdBy: chatRoomModelMap[crs.lastChatRecdBy] ?? "",
      lastChatTime: chatRoomModelMap[crs.lastChatTime],
      lastChatType: chatRoomModelMap[crs.lastChatType] ?? "string",
      lastChatString: chatRoomModelMap[crs.lastChatString] ?? "",
      lastChatMap: chatRoomModelMap[crs.lastChatMap],
      isChatRestricted: chatRoomModelMap[crs.isChatRestricted] ?? false,
      chatRestrictionMaps: chatRoomModelMap[crs.chatRestrictionMaps],
    );
  }
}
