import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

ChatRoomScreenController crsc = ChatRoomScreenController();

class ChatRoomScreenController {
  final selectedDRlist =
      RxList<DocumentReference<Map<String, dynamic>>>([]).obs;
}
