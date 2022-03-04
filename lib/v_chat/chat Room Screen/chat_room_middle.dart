import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/global%20Strings/global_strings.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/controllers/chat_controller.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatRoomMiddle extends StatelessWidget {
  ChatRoomMiddle({Key? key}) : super(key: key);

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
              .collection(gs.chatRooms)
              .doc(cc.thisChatDocID.value)
              .collection(gs.messages)
              .orderBy(gs.chatTime, descending: true),

          // .orderBy(gs.lastChatTime, descending: true),
          itemBuilder: (context, snapshot) {
            Map<String, dynamic> messageMap = snapshot.data();
            MessageModel crm = MessageModel.fromMap(messageMap);
            String ampm =
                DateFormat("a").format(crm.chatTime.toDate()).toLowerCase();
            String chatDayTime =
                DateFormat("dd MMM h:mm ").format(crm.chatTime.toDate()) + ampm;
            //
            String today = DateFormat("dd MMM").format(DateTime.now());
            String chatDay = DateFormat("dd MMM").format(crm.chatTime.toDate());

            if (today == chatDay)
              chatDayTime =
                  DateFormat("h:mm ").format(crm.chatTime.toDate()) + ampm;
            double textPadding = 20.0;
            String chatString = crm.chatString ?? "";
            if (chatString.length > 10) {
              textPadding = 20.0;
            }
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
                        Text(chatDayTime, textScaleFactor: 0.85),
                        SizedBox(width: 2),
                        Icon(
                          crm.isChatUploaded ? MdiIcons.check : MdiIcons.cached,
                          color: Colors.black,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 4 / 5),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, textPadding, 3),
                        child: Text(crm.chatString ?? ""),
                      ),
                      SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(chatDayTime, textScaleFactor: 0.85),
                              SizedBox(width: 2),
                              Icon(
                                crm.isChatUploaded
                                    ? MdiIcons.check
                                    : MdiIcons.cached,
                                color: Colors.black,
                                size: 18,
                              ),
                            ],
                          ),
                          width: 80),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
