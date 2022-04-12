import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';

class MessageModel {
  String chatSentBy;
  String chatRecdBy;
  bool isChatString;
  String? docID;
  Timestamp senderSentTime;
  Timestamp? recieverSeenTime;

  String? chatString;
  String? chatType;
  List? listSelection;
  List? listDocMaps;

  MessageModel({
    this.docID,
    required this.chatSentBy,
    required this.chatRecdBy,
    required this.senderSentTime,
    this.isChatString = true,
    this.recieverSeenTime,
    this.chatString,
    this.chatType,
    this.listDocMaps,
  });

  Map<String, dynamic> toMap() {
    return {
      mms.docID: docID,
      mms.chatSentBy: chatSentBy,
      mms.chatRecdBy: chatRecdBy,
      mms.senderSentTime: senderSentTime,
      mms.isChatString: isChatString,
      mms.recieverSeenTime: recieverSeenTime,
      mms.chatString: chatString,
      mms.chatType: chatType,
      mms.listDocMaps: listDocMaps,
    };
  }

  factory MessageModel.fromMap(Map messageMap) {
    return MessageModel(
      docID: messageMap[mms.docID],
      chatSentBy: messageMap[mms.chatSentBy],
      chatRecdBy: messageMap[mms.chatRecdBy],
      senderSentTime: messageMap[mms.senderSentTime],
      isChatString: messageMap[mms.isChatString],
      recieverSeenTime: messageMap[mms.recieverSeenTime],
      chatString: messageMap[mms.chatString],
      chatType: messageMap[mms.chatType],
      listDocMaps: messageMap[mms.listDocMaps],
    );
  }
}

MessageModelObjects mmos = MessageModelObjects();

class MessageModelObjects {
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
}
