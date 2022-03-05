import 'package:cloud_firestore/cloud_firestore.dart';

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
            MessageModel crm = MessageModel.fromMap(messageMap);

            
            return Column(
              children: [
                Align(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 100,
                        maxWidth: MediaQuery.of(context).size.width * 4 / 5,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(crm.chatString ?? ""),
                      ),
                    ),
                  ),
                  alignment: Alignment.bottomRight,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(chatTimeString(crm.senderSentTime),
                            textScaleFactor: 0.85),
                        const SizedBox(width: 2),
                        tickIcon(
                            crm.senderSentTime, crm.recieverSeenTime, crm.docID)
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
