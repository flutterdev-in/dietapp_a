import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/nav%20bar/a_colllecton_view_navbar.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/nav%20bar/b_plan_view_for_chat.dart';
import 'package:dietapp_a/v_chat/constants/chat_const_variables.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';
import 'package:dietapp_a/x_customWidgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';

class ChatRoomBottom extends StatelessWidget {
  bool isSuffixButtonsRequired;
  ChatRoomBottom({
    Key? key,
    this.isSuffixButtonsRequired = true,
  }) : super(key: key);
  Rx<String> tcString = ''.obs;
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
                child: Obx(() => TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: tc,
                      decoration: InputDecoration(
                        suffixIcon: (tcString.value.length < 1 &&
                                isSuffixButtonsRequired)
                            ? suffixIconW(context)
                            : null,
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Message...',
                        contentPadding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                      ),
                      onChanged: (value) {
                        tcString.value = value;
                      },
                    )),
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
                    String tcText = tcString.value;
                    tc.clear();
                    tcString.value = "";
                    if (tcText.replaceAll(" ", "") != "") {
                      //
                      await FirebaseFirestore.instance
                          .collection(crs.chatRooms)
                          .doc(thisChatDocID.value)
                          .collection(crs.chats)
                          .add(
                            MessageModel(
                              chatSentBy: userUID,
                              chatRecdBy: thisChatPersonUID.value,
                              chatString: tcText,
                              senderSentTime:
                                  Timestamp.fromDate(DateTime.now()),
                            ).toMap(),
                          )
                          .then((docRf) async {
                        await docRf.update(
                          {
                            mms.docID: docRf.id,
                            mms.senderSentTime:
                                Timestamp.fromDate(DateTime.now()),
                            mms.recieverSeenTime: isChatPersonOnChat.value
                                ? Timestamp.fromDate(DateTime.now())
                                : null,
                          },
                        );
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

  Widget suffixIconW(BuildContext context) {
    return SizedBox(
      width: 125,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(MdiIcons.paperclip),
            ),
            highlightColor: Colors.purple,
            splashColor: Colors.purple,
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(MdiIcons.paperclip),
            ),
            highlightColor: Colors.purple,
            splashColor: Colors.purple,
            onTap: () {
              bottomSheetW(
                context,
                CollectionViewNavBar(),
              );
            },
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(MdiIcons.paperclip),
            ),
            highlightColor: Colors.purple,
            splashColor: Colors.purple,
            onTap: () {
              bottomSheetW(
                context,
                PlanViewForChat(),
              );
            },
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}
