import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';

class DietChatRequestModel {
  bool isDietViewRequest;
  bool? isApproved;
  DateTime? actionTime;

  DietChatRequestModel({
    required this.isDietViewRequest,
    required this.isApproved,
    required this.actionTime,
  });

  Map<String, dynamic> toMap() {
    return {
      chatTS.isDietViewRequest: isDietViewRequest,
      chatTS.isApproved: isApproved,
      "actionTime": actionTime != null ? Timestamp.fromDate(actionTime!) : null,
    };
  }

  factory DietChatRequestModel.fromMap(Map messageMap) {
    return DietChatRequestModel(
      isDietViewRequest: messageMap[chatTS.isDietViewRequest],
      isApproved: messageMap[chatTS.isApproved],
      actionTime: messageMap["actionTime"]?.toDate(),
    );
  }
}
