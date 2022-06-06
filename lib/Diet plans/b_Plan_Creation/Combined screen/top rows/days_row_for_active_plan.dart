import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DaysRowForActivePlan extends StatelessWidget {
  final bool isForSingleDayActive;
  const DaysRowForActivePlan(this.isForSingleDayActive, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mw = MediaQuery.of(context).size.width;
    pcc.listDaysDR.value.clear();
    var activeDays = nest15days();
    return isForSingleDayActive
        ? singleDayW()
        : SizedBox(
            width: mw,
            height: 45,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (context, index) {
                  var dayDate = activeDays[index];
                  var docRef = admos.activeDayDR(dayDate, userUID);
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 1, 0),
                    child: InkWell(
                      child: Obx(() => Container(
                            width: mw / 7,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(1)),
                              border: Border.all(color: Colors.black26),
                              color: pcc.currentDayDR.value == docRef
                                  ? Colors.deepPurple.shade200
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                              child: Center(
                                  child: Column(
                                children: [
                                  Text(DateFormat("MMM").format(dayDate)),
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat("dd").format(dayDate),
                                        ),
                                        StreamBuilder<
                                                DocumentSnapshot<
                                                    Map<String, dynamic>>>(
                                            stream: docRef.snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData &&
                                                  snapshot.data!.data() !=
                                                      null) {
                                                return const Text("p",
                                                    textScaleFactor: 0.7);
                                              }
                                              return const SizedBox();
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                            ),
                          )),
                      onTap: () async {
                        pcc.currentDayDR.value = docRef;
                        pcc.currentTimingDR.value = await pcc
                            .getTimingDRfromDay(pcc.currentDayDR.value);
                      },
                    ),
                  );
                }),
          );
  }

  Widget singleDayW() {
    var dayDate = admos.dateFromDayDR(pcc.currentDayDR.value);
    var dayString = DateFormat("dd MMM yyyy (EEEE)").format(dayDate);
    return Container(
      width: Get.width,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(1)),
          border: Border.all(color: Colors.black26),
          color: Colors.deepPurple.shade200),
      child: Center(child: Text(dayString)),
    );
  }

  List<DateTime> nest15days() {
    var today = admos.dateZeroTime(DateTime.now());
    List<DateTime> l = [today];

    for (var i in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]) {
      l.add(today.add(Duration(days: i)));
    }
    return l;
  }
}
