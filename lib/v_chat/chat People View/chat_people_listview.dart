import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/global%20Strings/global_strings.dart';
import 'package:dietapp_a/userData/uid.dart';
import 'package:dietapp_a/v_chat/chat%20People%20View/chat_person_tile.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/_chat_room_screen.dart';
import 'package:dietapp_a/v_chat/chat%20Room/chat_room_model.dart';
import 'package:dietapp_a/v_chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class ChatPeopleListview extends StatelessWidget {
  const ChatPeopleListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        myBookMarkChat(),
        chatBodyStreamWidget(),
      ]),
    );
  }
}

Widget myBookMarkChat() {
  return GFListTile(
    avatar: FaIcon(FontAwesomeIcons.bookmark),
    titleText: "My Chats",
    onTap: () {
      String docID = uid + "_" + uid;
      cc.thisChatDocID.value = docID;
      cc.thisChatPersonUID.value = uid;
      Get.to(() => ChatRoomScreen(),
          opaque: false, transition: Transition.leftToRightWithFade);
    },
  );
}

Widget chatBodyStreamWidget() {
  return FirestoreListView<Map<String, dynamic>>(
    shrinkWrap: true,
    query: FirebaseFirestore.instance
        .collection(gs.chatRooms)
        .where(gs.chatMembers, arrayContains: uid),
    // .orderBy(gs.lastChatTime, descending: true),
    itemBuilder: (context, snapshot) {
      Map<String, dynamic> chatRoomMap = snapshot.data();
      ChatRoomModel crm = ChatRoomModel.fromMap(chatRoomMap);
      String chatPersonUID =
          crm.chatMembers[0] == uid ? crm.chatMembers[1] : crm.chatMembers[0];
      return ChatRoomTile(
        chatPersonUID: chatPersonUID,
        chatRoomMap: chatRoomMap,
      );
    },
  );
}
