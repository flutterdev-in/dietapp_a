import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/diet%20Room%20Screen/_diet_room_controller.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError || !(snapshot.data?.exists ?? true)) {
            return const Text("Error while fetching data, please try again");
          } else {
            ChatRoomModel crmNew =
                ChatRoomModel.fromMap(snapshot.data!.data()!);
            crmNew.chatDR = snapshot.data!.reference;
            if (crmNew.chatPersonModel.isDietAllowed) {
              return Column(
                children: [
                  monthCalander(),
                  const TimingsViewDietRoom(),
                ],
              );
            } else {
              var sendDate = "";
              bool isSameDay = false;

              if (crmNew.userModel.dietRequestSendTime != null) {
                sendDate = DateFormat("dd MMM yyyy, hh:mm a")
                    .format(crm.userModel.dietRequestSendTime!);
                int days = DateTime.now()
                    .difference(crm.userModel.dietRequestSendTime!)
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
                          }),
                  ],
                ),
              );
            }
          }
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
