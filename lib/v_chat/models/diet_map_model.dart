// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dietapp_a/v_chat/constants/chat_strings.dart';

// class DietMapModel {
//   String chatSentBy;
//   String chatRecdBy;
//   bool isChatString;
//   String? docID;
//   DocumentReference? docRef;
//   Timestamp senderSentTime;
//   Timestamp? recieverSeenTime;

//   String? chatString;
//   Map<String, dynamic>? chatMap;

//   DietMapModel({
//     this.docID,
//     required this.chatSentBy,
//     required this.chatRecdBy,
//     required this.senderSentTime,
//     this.isChatString = true,
//     this.recieverSeenTime,
//     this.chatString,
//     this.chatMap,
//     this.docRef,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       mms.docID: docID,
//       mms.chatSentBy: chatSentBy,
//       mms.chatRecdBy: chatRecdBy,
//       mms.senderSentTime: senderSentTime,
//       mms.isChatString: isChatString,
//       mms.recieverSeenTime: recieverSeenTime,
//       mms.chatString: chatString,
//       mms.chatMap: chatMap,
//       mms.docRef: docRef,
//     };
//   }

//   factory DietMapModel.fromMap(Map messageMap) {
//     return DietMapModel(
//       docID: messageMap[mms.docID],
//       chatSentBy: messageMap[mms.chatSentBy],
//       chatRecdBy: messageMap[mms.chatRecdBy],
//       senderSentTime: messageMap[mms.senderSentTime],
//       isChatString: messageMap[mms.isChatString],
//       recieverSeenTime: messageMap[mms.recieverSeenTime],
//       chatString: messageMap[mms.chatString],
//       chatMap: messageMap[mms.chatMap],
//       docRef: messageMap[mms.docRef],
//     );
//   }
// }
