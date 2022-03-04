import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/global%20Strings/global_strings.dart';
import 'package:dietapp_a/userData/uid.dart';
import 'package:dietapp_a/v_chat/chat_controller.dart';
import 'package:dietapp_a/v_chat/messageFiles/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatRoomBottom extends StatelessWidget {
  const ChatRoomBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<String> textFieldData = "".obs;
    TextEditingController tc = TextEditingController();
    return Container(
      color: Colors.teal.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 4 / 5 - 10,
                maxHeight: 120,
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: tc,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Message',
                        border: InputBorder.none),
                    onChanged: (value) {
                      textFieldData.value = value.toString();
                    }),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GFAvatar(
                size: GFSize.SMALL,
                child: IconButton(
                  icon: const Icon(MdiIcons.send),
                  onPressed: () async {
                    tc.clear();
                    if (textFieldData.value.replaceAll(" ", "") != "") {
                      String textFieldString = textFieldData.value;
                      textFieldData.value = "";
                      Map<String, dynamic> msm = MessageModel(
                        chatSentBy: uid,
                        chatRecdBy: cc.thisChatPersonUID.value,
                        chatTime: Timestamp.fromDate(DateTime.now()),
                        isChatUploaded: false,
                        chatType: "String",
                        chatString: textFieldString,
                      ).toMap();

                      await FirebaseFirestore.instance
                          .collection(gs.chatRooms)
                          .doc(cc.thisChatDocID.value)
                          .collection(gs.messages)
                          .add(msm)
                          .then((docRf) async {
                        return await docRf.update(
                            {"isChatUploaded": true, "docID": docRf.id});
                      });
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
