import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';

class PlannedActiveFunctions {
  ActiveDayModel activeDayFromPlanned({
    required DayModel dm,
    required String date,
    required DocumentReference<Map<String, dynamic>>? activatedPlanDocDR,
  }) {
    return ActiveDayModel(
      dayDate: date,
      isPlanned: true,
      dayName: dm.dayName ?? "",
      plannedNotes: dm.notes,
      prud: dm.rumm,
      refPlanDR: activatedPlanDocDR,
    );
  }

  Future<void> activatePlannedWeek({
    required DateTime startDate,
    required DocumentReference<Map<String, dynamic>> weekDR,
    required DocumentReference<Map<String, dynamic>>? activatedPlanDocDR,
  }) async {
    String? laspsedDecisionStSkOvSkaOva;
    List<String> listDates = [];
    for (int i in [0, 1, 2, 3, 4, 5, 6]) {
      listDates.add(admos.dayStringFromDate(startDate.add(Duration(days: i))));
    }
    for (String date in listDates) {
      await userDR
          .collection(admos.activeDaysPlan)
          .doc(date)
          .get()
          .then((dayDR) async {
        if (dayDR.exists && dayDR.data() != null) {
        } else {
          int dayIndex = listDates.indexOf(date) + 1;
          weekDR
              .collection(daymfos.days)
              .where(daymfos.dayIndex, isEqualTo: dayIndex)
              .limit(1)
              .get()
              .then((dayQS) async {
            if (dayQS.docs.isNotEmpty) {
              var dayDoc = dayQS.docs.first;

              ActiveDayModel adm = activeDayFromPlanned(
                  dm: DayModel.fromMap(dayDoc.data()),
                  date: date,
                  activatedPlanDocDR: activatedPlanDocDR);
              DocumentReference<Map<String, dynamic>> activeDayDR =
                  userDR.collection(admos.activeDaysPlan).doc(date);
              await activeDayDR.set(adm.toMap()).then((value) async {
                await dayDoc.reference
                    .collection(dtmos.timings)
                    .get()
                    .then((tQS) async {
                  if (tQS.docs.isNotEmpty) {
                    for (var tqds in tQS.docs) {
                      DocumentReference<Map<String, dynamic>> plannedTimmingDR =
                          tqds.reference;
                          
                    }
                  }
                });
              });
            }
          });
        }
      });
    }
  }
}
