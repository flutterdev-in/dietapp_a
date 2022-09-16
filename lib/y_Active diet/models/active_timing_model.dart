import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Models/day_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';

final ActiveTimingModelObjects atmos = ActiveTimingModelObjects();

class ActiveTimingModelObjects {
  var basicModel = TimingModel(timingName: "BreakFast", timingString: "am0830");

  //
  Future<void> setDefaultTimings(
      DocumentReference<Map<String, dynamic>> activeDayDR) async {
    await dtmos.getDefaultTimings().then((listDTMs) async {
      for (var i in listDTMs) {
        await activeDayDR
            .collection(tmos.timings)
            .doc(i.timingString)
            .set(i.toMap(), SetOptions(merge: true));
      }
    });
  }

  Future<void> activateDefaultTimings(
      DocumentReference<Map<String, dynamic>> dayDR) async {
    await dayDR
        .set(
            DayModel(
              dayDate: DateTime.parse(dayDR.id),
              dayCreatedTime: null,
              dayIndex: null,
            ).toMap(),
            SetOptions(merge: true))
        .then((value) async {
      await setDefaultTimings(dayDR);
    });
  }

  Future<void> checkAndSetDefaultTimings(DateTime dayDate) async {
    var activeDayDR = admos.activeDayDR(dayDate, userUID);
    await activeDayDR.get().then((ds) async {
      if (!ds.exists || ds.data() == null) {
        await activeDayDR
            .set(
                DayModel(
                  dayDate: DateTime.parse(activeDayDR.id),
                  dayCreatedTime: null,
                  dayIndex: null,
                ).toMap(),
                SetOptions(merge: true))
            .then((value) async {
          await setDefaultTimings(activeDayDR);
        });
      } else {
        await activeDayDR
            .collection(tmos.timings)
            .limit(1)
            .get()
            .then((qs) async {
          if (qs.docs.isEmpty) {
            await setDefaultTimings(activeDayDR);
          }
        });
      }
    });
  }
}
