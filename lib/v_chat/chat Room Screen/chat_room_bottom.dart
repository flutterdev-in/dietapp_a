import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/controllers/chat_controller.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatRoomBottom extends StatelessWidget {
  const ChatRoomBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      hintText: 'Message...',
                      border: InputBorder.none),
                ),
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
                    String tcText = tc.text;
                    tc.clear();
                    if (tcText.replaceAll(" ", "") != "") {
                      Map<String, dynamic> msm = MessageModel(
                        chatSentBy: userUID,
                        chatRecdBy: cc.thisChatPersonUID.value,
                        chatTime: Timestamp.fromDate(DateTime.now()),
                        isChatUploaded: false,
                        chatType: crs.string,
                        chatString: tcText,
                      ).toMap();

                      //
                      await FirebaseFirestore.instance
                          .collection(crs.chatRooms)
                          .doc(cc.thisChatDocID.value)
                          .collection(crs.messages)
                          .add(msm)
                          .then((docRf) async {
                        return await docRf.update(
                            {mms.isChatUploaded: true, mms.docID: docRf.id});
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
