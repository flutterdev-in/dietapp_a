import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/x_FCM/fcm_model.dart';

class MessageModel {
  String chatSentBy;
  String chatRecdBy;
  DocumentReference<Map<String, dynamic>>? docRef;
  DateTime senderSentTime;
  DateTime? recieverSeenTime;
  String? chatString;
  String? chatType;
  List? listDocMaps;
  FcmModel fcmModel;
  MessageModel? replyMessageModel;

  MessageModel({
    this.docRef,
    required this.chatSentBy,
    required this.chatRecdBy,
    required this.senderSentTime,
    this.recieverSeenTime,
    this.chatString,
    this.chatType,
    this.listDocMaps,
    required this.fcmModel,
    this.replyMessageModel,
  });

  Map<String, dynamic> toMap() {
    return {
      mmos.senderSentTime: Timestamp.fromDate(senderSentTime),
      mmos.chatType: chatType,
      mmos.chatRecdBy: chatRecdBy,
      mmos.recieverSeenTime: recieverSeenTime != null
          ? Timestamp.fromDate(recieverSeenTime!)
          : null,
      unIndexed: {
        mmos.docRef: docRef,
        mmos.chatSentBy: chatSentBy,
        fcmos.fcmModel: fcmModel.toMap(),
        mmos.chatString: chatString,
        mmos.listDocMaps: listDocMaps,
      }
    };
  }

  factory MessageModel.fromMap(Map messageMap) {
    return MessageModel(
      docRef: messageMap[unIndexed][mmos.docRef],
      chatSentBy: messageMap[unIndexed][mmos.chatSentBy] ?? "",
      chatRecdBy: messageMap[mmos.chatRecdBy] ?? "",
      senderSentTime: messageMap[mmos.senderSentTime]?.toDate(),
      recieverSeenTime: messageMap[mmos.recieverSeenTime]?.toDate(),
      chatString: messageMap[unIndexed][mmos.chatString],
      chatType: messageMap[mmos.chatType],
      listDocMaps: messageMap[unIndexed][mmos.listDocMaps],
      fcmModel: FcmModel.fromMap(messageMap[unIndexed][fcmos.fcmModel] ?? {}),
    );
  }

  DocumentReference<Map<String, dynamic>> chatRoomDR() {
    return crs.chatDRf([chatSentBy, chatRecdBy]);
  }
}

MessageModelObjects mmos = MessageModelObjects();

class MessageModelObjects {
  String docID = "docID";
  String docRef = docRef0;
  String chatSentBy = "chatSentBy";
  String chatRecdBy = "chatRecdBy";
  String isChatUploaded = "isChatUploaded";
  String senderSentTime = "senderSentTime";

  String isChatString = "isChatString";
  String chatString = "chatString";
  String chatMap = "chatMap";
  String recieverSeenTime = "recieverSeenTime";
  String isRecieverOnChat = "isRecieverOnChat";
  String recieverToken = "recieverToken";
  final String chatType = "chatType";
  final String listDocMaps = "listDocMaps";
  final String collection = "collection";
  final String dietPlan = "dietPlan";
  final String dietPlansBeta = "dietPlansBeta";
}

ChatTypesStrings chatTS = ChatTypesStrings();

class ChatTypesStrings {
  //
  final planView = "planView";
  final collectionView = "collectionView";
  //
  final foodsCollection = userDR.collection("foodsCollection").path;
  final dietPlansBeta = userDR.collection("dietPlansBeta").path;

  //
  final stringOnly = "stringOnly";
  //
  final singleYoutube = "singleYoutube";
  final singleWebFood = "singleWebFood";
  final singleCustomFood = "singleCustomFood";
  final singleWebFolder = "singleWebFolder";
  final singleFolder = "singleFolder";
  final singleTiming = "singleTiming";
  final singleDay = "singleDay";
  final singleWeek = "singleWeek";
  final singlePlan = "singlePlan";
  //
  final multiFoodCollection = "multiFoodCollection";
  final multiTiming = "multiTiming";
  final multiDay = "multiDay";
  final multiWeek = "multiWeek";
  final multiPlan = "multiPlan";
  final viewRequest = "viewRequest";

  final isApproved = "isApproved";
  final isDietViewRequest = "isDietViewRequest";
}
