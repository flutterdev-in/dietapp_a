import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';

class ChatRoomModel {
  List chatMembers;
  DateTime lastChatTime;
  String lastChatSentBy;
  String lastChatRecdBy;
  ChatMemberModel userModel;
  ChatMemberModel chatPersonModel;
  MessageModel? lastChatModel;
  String chatPersonUID;
  DocumentReference<Map<String, dynamic>> chatDR;
  //
  ChatRoomModel({
    required this.chatMembers,
    required this.lastChatTime,
    required this.lastChatSentBy,
    required this.lastChatRecdBy,
    required this.userModel,
    required this.chatPersonModel,
    required this.lastChatModel,
    required this.chatPersonUID,
    required this.chatDR,
  });

  Map<String, dynamic> toMap() {
    return {
      crs.chatMembers: chatMembers,
      crs.lastChatTime: Timestamp.fromDate(lastChatTime),
      unIndexed: {
        crs.lastChatSentBy: lastChatSentBy,
        crs.lastChatRecdBy: lastChatRecdBy,
        userUID: userModel.toMap(),
        chatPersonUID: chatPersonModel.toMap(),
        crs.lastChatModel: lastChatModel?.toMap(),
        crs.chatDR: chatDR,
      }
    };
  }

  factory ChatRoomModel.fromMap(Map chatRoomModelMap) {
    List chatMembers0 = chatRoomModelMap[crs.chatMembers] ?? [userUID, userUID];
    String chatPersonUID0 = chatMembers0[0];
    if (chatPersonUID0 == userUID) {
      chatPersonUID0 = chatMembers0[0];
    }

    var lastChatMap = chatRoomModelMap[unIndexed][crs.lastChatModel];
    return ChatRoomModel(
      chatMembers: chatMembers0,
      lastChatTime: chatRoomModelMap[crs.lastChatTime]?.toDate() ?? DateTime.now(),
      lastChatSentBy:
          chatRoomModelMap[unIndexed][crs.lastChatSentBy] ?? userUID,
      lastChatRecdBy:
          chatRoomModelMap[unIndexed][crs.lastChatRecdBy] ?? userUID,
      userModel: ChatMemberModel.fromMap(chatRoomModelMap[unIndexed][userUID]),
      chatPersonModel:
          ChatMemberModel.fromMap(chatRoomModelMap[unIndexed][chatPersonUID0]),
      lastChatModel:
          lastChatMap != null ? MessageModel.fromMap(lastChatMap) : null,
      chatPersonUID: chatPersonUID0,
      chatDR:
          chatRoomModelMap[unIndexed][crs.chatDR] ?? crs.chatDRf(chatMembers0),
    );
  }
}

class ChatMemberModel {
  bool isChatAllowed;
  bool isDietAllowed;
  bool isThisChatOpen;

  ChatMemberModel({
    required this.isChatAllowed,
    required this.isDietAllowed,
    required this.isThisChatOpen,
  });

  Map<String, dynamic> toMap() {
    return {
      crs.isChatAllowed: isChatAllowed,
      crs.isDietAllowed: isDietAllowed,
      crs.isThisChatOpen: isThisChatOpen,
    };
  }

  factory ChatMemberModel.fromMap(Map chatMemberModelMap) {
    return ChatMemberModel(
      isChatAllowed: chatMemberModelMap[crs.isChatAllowed] ?? false,
      isDietAllowed: chatMemberModelMap[crs.isDietAllowed] ?? false,
      isThisChatOpen: chatMemberModelMap[crs.isThisChatOpen] ?? false,
    );
  }
}

ChatRoomStrings crs = ChatRoomStrings();

class ChatRoomStrings {
  String chatDR = "chatDR";
  String chatMembers = "chatMembers";
  String lastChatSentBy = "lastChatSentBy";
  String lastChatRecdBy = "lastChatRecdBy";
  String lastChatTime = "lastChatTime";

  String isChatAllowed = "isChatAllowed";
  String isDietAllowed = "isDietAllowed";
  String isThisChatOpen = "isThisChatOpen";
  String lastChatModel = "lastChatModel";
  //FireStrings

  final String chatRooms = "chatRooms";
  String chats = "chats";

  String string = "string";

  //
  String chatBox = "chatBox";
  String thisChatPersonUID = "thisChatPersonUID";
  String thisChatDocID = "thisChatDocID";

  DocumentReference<Map<String, dynamic>> chatDRf(List chatMembers) {
    chatMembers.sort();
    return FirebaseFirestore.instance
        .collection(chatRooms)
        .doc("${chatMembers[0]}_${chatMembers[1]}");
  }

  Future<ChatRoomModel> chatRoomModelFromChatPersonUID(
      String chatPersonUID) async {
    return await chatDRf([userUID, chatPersonUID]).get().then((ds) async {
      if (!ds.exists || ds.data() != null) {
        var crm = ChatRoomModel(
            chatMembers: [userUID, chatPersonUID],
            lastChatTime: DateTime.now(),
            lastChatSentBy: userUID,
            lastChatRecdBy: chatPersonUID,
            userModel: ChatMemberModel(
                isChatAllowed: true,
                isDietAllowed: chatPersonUID == userUID ? true : false,
                isThisChatOpen: false),
            chatPersonModel: ChatMemberModel(
                isChatAllowed: true,
                isDietAllowed: chatPersonUID == userUID ? true : false,
                isThisChatOpen: false),
            lastChatModel: null,
            chatDR: chatDRf([userUID, chatPersonUID]),
            chatPersonUID: userUID);

        await chatDRf([userUID, chatPersonUID])
            .set(crm.toMap(), SetOptions(merge: true));
        return crm;
      } else {
        return ChatRoomModel.fromMap(ds.data()!);
      }
    });
  }
}
