import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/global%20Strings/global_strings.dart';
import 'package:dietapp_a/userData/uid.dart';
import 'package:dietapp_a/v_chat/messageFiles/message_model.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatRoomBottom extends StatelessWidget {
  late final String chatPersonUID;
  late final String docID;
  ChatRoomBottom(
    this.chatPersonUID,
    this.docID, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String textFieldData = "";
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                textFieldData = value.toString();
              }),
          flex: 4,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () async {
                Map<String, dynamic> msm = MessageModel(
                  chatSentBy: uid,
                  chatRecdBy: chatPersonUID,
                  chatTime: Timestamp.fromDate(DateTime.now()),
                  chatType: "String",
                  chatString: textFieldData,
                ).toMap();

                await FirebaseFirestore.instance
                    .collection(gs.chatRooms)
                    .doc(docID)
                    .collection(gs.messages)
                    .add(msm);
              },
              icon: Icon(MdiIcons.send),
            ),
          ),
        )
      ],
    );
  }
}
