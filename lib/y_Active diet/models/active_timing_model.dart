import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/y_Active%20diet/functions/active_model_from_planned_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:intl/intl.dart';

class ActiveTimingModel {
  String timingName;
  String timingString;
  String? notes;
  RefUrlMetadataModel? rumm;
  DocumentReference<Map<String, dynamic>>? docRef;

  //
  ActiveTimingModel({
    required this.timingName,
    required this.timingString,
    this.notes,
    this.rumm,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      atmos.timingName: timingName,
      atmos.timingString: timingString,
      unIndexed: {}
    };
    Map<String, dynamic> nullChaeckValues = {
      notes0: notes,
      rummfos.rumm: rumm?.toMap(),
      docRef0: docRef,
    };

    nullChaeckValues.forEach((key, value) {
      if (value != null) {
        returnMap[unIndexed][key] = value;
      }
    });

    return returnMap;
  }

  factory ActiveTimingModel.fromMap(Map docMap) {
    return ActiveTimingModel(
      timingName: docMap[atmos.timingName] ?? "",
      timingString: docMap[atmos.timingString],
      notes: docMap[unIndexed][notes0],
      rumm: rummfos.rummFromRummMap(docMap[unIndexed][rummfos.rumm]),
      docRef: docMap[unIndexed][docRef0],
    );
  }
}

final ActiveTimingModelObjects atmos = ActiveTimingModelObjects();

class ActiveTimingModelObjects {
  final String timingName = "timingName";
  final String timings = "timings";
  final String timingString = "timingString";
  final String timingDate = "timingDate";

  String timingStringFromDateTime(Timestamp timeDate) {
    DateTime timeDate0 = timeDate.toDate();
    String s = DateFormat("h:mma").format(timeDate0).toLowerCase();
    return s;
  }

  String timingFireStringFromDateTime(DateTime date) {
    String s = DateFormat("ahhmm").format(date).toLowerCase();
    return s;
  }

  Timestamp timeDateFromDayTime(DateTime dateTime, String timeString) {
    String dayString = DateFormat("yMd").format(dateTime);
    timeString = timeString.toUpperCase();
    DateTime dt = DateFormat('yMd h:mma').parse("$dayString $timeString");
    return Timestamp.fromDate(dt);
  }

  var basicModel =
      ActiveTimingModel(timingName: "BreakFast", timingString: "am0830");

  //
  Future<void> setDefaultTimings(
      DocumentReference<Map<String, dynamic>> activeDayDR) async {
    await dtmos.getDefaultTimings().then((listDTMs) async {
      for (var i in listDTMs) {
        await activeDayDR
            .collection(atmos.timings)
            .doc(i.timingString)
            .set(amfpm.timingModel(dtm: i).toMap(), SetOptions(merge: true));
      }
    });
  }

  Future<void> activateDefaultTimings(
      DocumentReference<Map<String, dynamic>> dayDR) async {
    await dayDR
        .set(
            ActiveDayModel(
              dayDate: DateTime.parse(dayDR.id),
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
                ActiveDayModel(
                  dayDate: DateTime.parse(activeDayDR.id),
                ).toMap(),
                SetOptions(merge: true))
            .then((value) async {
          await setDefaultTimings(activeDayDR);
        });
      } else {
        await activeDayDR
            .collection(atmos.timings)
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
