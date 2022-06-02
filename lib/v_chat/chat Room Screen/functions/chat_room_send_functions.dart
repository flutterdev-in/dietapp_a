import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';

class ChatRoomSendFunctions {
  Future<void> updateChatDocAfterSend({
    required DocumentReference<Map<String, dynamic>> chatRoomDR,
    required DocumentReference<Map<String, dynamic>> lastChatDR,
    required String lastChatSentBy,
    required String lastChatRecdBy,
  }) async {
    chatRoomDR.update({
      crs.lastChatTime: Timestamp.fromDate(DateTime.now()),
      "$unIndexed.${crs.lastChatModel}":
          await lastChatDR.get().then((value) => value.data()),
      "$unIndexed.${crs.lastChatSentBy}": lastChatSentBy,
      "$unIndexed.${crs.lastChatRecdBy}": lastChatRecdBy,
    });
  }
}
