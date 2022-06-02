import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/functions/chat_room_functions.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/functions/chat_room_send_functions.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/nav%20bar/a_colllecton_view_navbar.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/nav%20bar/b_plan_view_for_chat.dart';
import 'package:dietapp_a/v_chat/constants/chat_const_variables.dart';
import 'package:dietapp_a/v_chat/controllers/chat_room_controller.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';
import 'package:dietapp_a/x_customWidgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatRoomBottom extends StatelessWidget {
  bool isSuffixButtonsRequired;
  ChatRoomBottom({
    Key? key,
    this.isSuffixButtonsRequired = true,
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
                child: Obx(() => TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: tc,
                      decoration: InputDecoration(
                        suffixIcon: (chatSC.tcText.value.isEmpty &&
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
                        chatSC.tcText.value = value;
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
                    String tcText = chatSC.tcText.value;
                    tc.clear();
                    chatSC.tcText.value = "";
                    List<Map<String, dynamic>>? listDocMaps;
                    String chatType = chatTS.stringOnly;

                    if (chatSC.selectedList.value.isNotEmpty) {
                      listDocMaps = ChatRoomFunctions().getFinalList();

                      chatType = chatSC.chatType.value;
                    }

                    if (tcText.replaceAll(" ", "") != "" ||
                        chatSC.selectedList.value.isNotEmpty) {
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
                              listDocMaps: listDocMaps,
                              chatType: chatType,
                            ).toMap(),
                          )
                          .then((docRf) async {
                        if (chatType != chatTS.stringOnly) {
                          Navigator.pop(context);
                        }

                        await docRf.update(
                          {
                            mmos.senderSentTime:
                                Timestamp.fromDate(DateTime.now()),
                            "$unIndexed.${mmos.recieverSeenTime}":
                                isChatPersonOnChat.value
                                    ? Timestamp.fromDate(DateTime.now())
                                    : null,
                            "$unIndexed.$docRef0": docRf
                          },
                        );

                        ChatRoomSendFunctions().updateChatDocAfterSend(
                            chatRoomDR: FirebaseFirestore.instance
                                .collection(crs.chatRooms)
                                .doc(thisChatDocID.value),
                            lastChatDR: docRf,
                       
                            lastChatSentBy: userUID,
                            lastChatRecdBy: thisChatPersonUID.value);
                      });

                      chatSC.chatType.value = chatTS.stringOnly;
                      chatSC.selectedList.value.clear();
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
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(MdiIcons.folderTextOutline),
            ),
            highlightColor: Colors.purple,
            splashColor: Colors.purple,
            onTap: () {
              chatSC.chatType.value = chatTS.collectionView;
              bottomSheetW(
                context,
                const CollectionViewNavBar(),
              );
            },
          ),
          InkWell(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(MdiIcons.clipboardTextOutline),
            ),
            highlightColor: Colors.purple,
            splashColor: Colors.purple,
            onTap: () {
              chatSC.chatType.value = chatTS.planView;
              bottomSheetW(
                context,
                PlanViewForChat(),
              );
            },
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
