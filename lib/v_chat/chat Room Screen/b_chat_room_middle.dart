import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/multi_foods_collection_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/single_chat_from_strem_w.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/single_folder_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/text_widget_chat.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/web_food_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/youtube_video_widget.dart';

import 'package:dietapp_a/v_chat/constants/chat_const_variables.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatRoomMiddle extends StatelessWidget {
  const ChatRoomMiddle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.teal.shade50,
        child: FirestoreListView<Map<String, dynamic>>(
          pageSize: 5,
          reverse: true,
          shrinkWrap: true,
          query: FirebaseFirestore.instance
              .collection(crs.chatRooms)
              .doc(thisChatDocID.value)
              .collection(crs.chats)
              .orderBy(mms.senderSentTime, descending: true),

          // .orderBy(gs.lastChatTime, descending: true),
          itemBuilder: (context, snapshot) {
            Map<String, dynamic> messageMap = snapshot.data();
            MessageModel mm = MessageModel.fromMap(messageMap);
            bool isSentByMe = mm.chatSentBy == userUID;

            return Column(
              children: [
                Align(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: chatWidget(mm),
                  ),
                  alignment:
                      isSentByMe ? Alignment.bottomRight : Alignment.bottomLeft,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                    child: Row(
                      mainAxisAlignment: isSentByMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Text(chatTimeString(mm.senderSentTime),
                            textScaleFactor: 0.85),
                        const SizedBox(width: 2),
                        if (isSentByMe)
                          tickIcon(
                              mm.senderSentTime, mm.recieverSeenTime, mm.docID)
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget chatWidget(MessageModel mm) {
  List? listDocMaps = mm.listDocMaps;

  if (mm.chatType == chatTS.singleYoutube) {
    Map<String, dynamic> map = listDocMaps!.first as Map<String, dynamic>;
    FoodsCollectionModel fdcm = FoodsCollectionModel.fromMap(map);
    return YoutubeVideoWidget(fdcm: fdcm, text: mm.chatString);
  } else if (mm.chatType == chatTS.singleWebFood) {
    Map<String, dynamic> map = listDocMaps!.first as Map<String, dynamic>;
    FoodsCollectionModel fdcm = FoodsCollectionModel.fromMap(map);
    return WebFoodMiddle(fdcm: fdcm, text: mm.chatString);
  } else if (mm.chatType == chatTS.singleFolder) {
    Map<String, dynamic> map = listDocMaps!.first as Map<String, dynamic>;
    FoodsCollectionModel fdcm = FoodsCollectionModel.fromMap(map);
    return SingleFolderMiddle(fdcm: fdcm, text: mm.chatString);
  } else if (mm.chatType == chatTS.multiFoodCollection) {
   
    return MultiFoodsCollectionMiddle(
        listFDCM: listDocMaps!.map((e) {
          Map<String, dynamic> map = e as Map<String, dynamic>;
          return FoodsCollectionModel.fromMap(map);
        }).toList(),
        text: mm.chatString);
  } else {
    return TextWidgetChatMiddle(mm: mm);
  }
}

String chatTimeString(Timestamp senderSentTime) {
  String ampm = DateFormat("a").format(senderSentTime.toDate()).toLowerCase();
  String chatDayTime =
      DateFormat("dd MMM h:mm ").format(senderSentTime.toDate()) + ampm;
  //
  String today = DateFormat("dd MMM").format(DateTime.now());
  String chatDay = DateFormat("dd MMM").format(senderSentTime.toDate());

  if (today == chatDay) {
    chatDayTime = DateFormat("h:mm ").format(senderSentTime.toDate()) + ampm;
  }

  return chatDayTime;
}

Icon tickIcon(
  Timestamp? senderSentTime,
  Timestamp? recieverSeenTime,
  String? docID,
) {
  if (recieverSeenTime != null) {
    return const Icon(
      MdiIcons.checkAll,
      color: Colors.blue,
      size: 18,
    );
  } else if (docID != null) {
    return const Icon(
      MdiIcons.check,
      color: Colors.black,
      size: 18,
    );
  } else {
    return const Icon(
      MdiIcons.cached,
      color: Colors.black,
      size: 18,
    );
  }
}
