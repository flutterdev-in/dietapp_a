import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/functions/chat_room_functions.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/functions/chat_room_send_functions.dart';
import 'package:dietapp_a/v_chat/diet%20Room%20Screen/_diet_room_controller.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/v_chat/models/message_model%20copy.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';
import 'package:dietapp_a/x_FCM/fcm_model.dart';
import 'package:dietapp_a/x_customWidgets/lootie_animations.dart';
import 'package:dietapp_a/x_customWidgets/month_calander.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import 'b_timing_view_diet_room.dart';

class DietViewChat extends StatelessWidget {
  final ChatRoomModel crm;
  const DietViewChat(this.crm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: crm.chatDR.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.data() != null) {
            ChatRoomModel crmNew =
                ChatRoomModel.fromMap(snapshot.data!.data()!);
            crmNew.chatDR = snapshot.data!.reference;
            if (crmNew.chatPersonModel.isDietAllowed) {
              return Column(
                children: [
                  monthCalander(),
                  Expanded(child: TimingsViewDietRoom(crm)),
                ],
              );
            } else {
              var sendDate = "";
              bool isSameDay = false;

              if (crmNew.userModel.dietRequestSendTime != null) {
                sendDate = DateFormat("dd MMM yyyy, hh:mm a")
                    .format(crmNew.userModel.dietRequestSendTime!);
                int days = DateTime.now()
                    .difference(crmNew.userModel.dietRequestSendTime!)
                    .inDays;
                if (days < 1) {
                  isSameDay = true;
                }
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                        "Diet view has been restricted by the user, get permission to view his diet"),
                    if (sendDate.isNotEmpty)
                      Text(
                        "\nLast request sent on \n $sendDate",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    if (!isSameDay)
                      GFButton(
                          child: sendDate.isNotEmpty
                              ? const Text("Send reminder")
                              : const Text("Send request"),
                          color: primaryColor,
                          onPressed: () async {
                            await Future.delayed(const Duration(seconds: 1));
                            crmNew.chatDR.update({
                              "$unIndexed.$userUID.${crs.dietRequestSendTime}":
                                  Timestamp.fromDate(DateTime.now()),
                            });

                            FcmModel fcmModel =
                                await ChatRoomFunctions.getFcmModel(crm);
                            fcmModel.fcmBody = fcmos.getFcmBody(
                                chatType: chatTS.viewRequest,
                                chatString: null,
                                fileName: null);

                            //
                            await crm.chatDR
                                .collection(crs.chats)
                                .add(
                                  MessageModel(
                                    chatSentBy: userUID,
                                    chatRecdBy: crmNew.chatPersonUID,
                                    chatString: null,
                                    senderSentTime: DateTime.now(),
                                    fcmModel: fcmModel,
                                    listDocMaps: [
                                      DietChatRequestModel(
                                              isDietViewRequest: true,
                                              isApproved: null,
                                              actionTime: null)
                                          .toMap(),
                                    ],
                                    chatType: chatTS.viewRequest,
                                  ).toMap(),
                                )
                                .then((docRf) async {
                              docRf.update(
                                {
                                  mmos.senderSentTime:
                                      Timestamp.fromDate(DateTime.now()),
                                  mmos.recieverSeenTime:
                                      fcmModel.isRecieverOnChat
                                          ? Timestamp.fromDate(DateTime.now())
                                          : null,
                                  "$unIndexed.$docRef0": docRf
                                },
                              );

                              ChatRoomSendFunctions().updateChatDocAfterSend(
                                  chatRoomDR: crm.chatDR,
                                  lastChatDR: docRf,
                                  lastChatSentBy: userUID,
                                  lastChatRecdBy: crm.chatPersonUID);

                              crm.chatDR
                                  .collection(crs.chats)
                                  .where(mmos.chatType,
                                      isEqualTo: chatTS.viewRequest)
                                  .where(mmos.chatRecdBy, isNotEqualTo: userUID)
                                  .get()
                                  .then((qs) async {
                                if (qs.docs.isNotEmpty) {
                                  var lr =
                                      qs.docs.map((e) => e.reference).toList();
                                  lr.remove(docRf);

                                  for (var i in lr) {
                                    await i.delete();
                                  }
                                }
                              });
                            });
                          }),
                  ],
                ),
              );
            }
          }
          return loot.sqareDotsLoading();
        });
  }

  Widget monthCalander() {
    return Obx(() => MonthCalander(
        currentDay: drc.calendarDate.value,
        personUID: userUID,
        onDaySelected: (selectedDate, focusedDate) async {
          drc.calendarDate.value = focusedDate;
          drc.currentDayDR.value =
              admos.activeDayDR(focusedDate, crm.chatPersonUID);
        },
        onCurrentCalanderPressed: () async {
          drc.calendarDate.value = DateTime.now().add(const Duration(days: 1));
          drc.calendarDate.value = DateTime.now();
          drc.currentDayDR.value =
              admos.activeDayDR(DateTime.now(), crm.chatPersonUID);
        }));
  }
}
