import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';

// class TimingModel {
//   String timingName;
//   String timingString;
//   String? notes;
//   RefUrlMetadataModel? rumm;
//   DocumentReference<Map<String, dynamic>>? docRef;

//   //
//   TimingModel({
//     required this.timingName,
//     required this.timingString,
//     this.notes,
//     this.rumm,
//     this.docRef,
//   });

//   Map<String, dynamic> toMap() {
//     Map<String, dynamic> returnMap = {
//       dtmos.timingName: timingName,
//       dtmos.timingString: timingString,
//       unIndexed: {}
//     };
//     Map<String, dynamic> nullChaeckValues = {
//       dtmos.notes: notes,
//       rummfos.rumm: rumm?.toMap(),
//       dtmos.docRef: docRef,
//     };
//     nullChaeckValues.forEach((key, value) {
//       if (value != null) {
//         returnMap[unIndexed][key] = value;
//       }
//     });

//     return returnMap;
//   }

//   Map<String, dynamic> toMapOnly2() {
//     return {
//       dtmos.timingName: timingName,
//       dtmos.timingString: timingString,
//     };
//   }

//   factory TimingModel.fromMap(Map dataMap) {
//     return TimingModel(
//       timingName: dataMap[dtmos.timingName],
//       timingString: dataMap[dtmos.timingString],
//       notes: dataMap[unIndexed][dtmos.notes],
//       rumm: rummfos.rummFromRummMap(dataMap[unIndexed][rummfos.rumm]),
//       docRef: dataMap[unIndexed][dtmos.docRef],
//     );
//   }
//   factory TimingModel.fromMapOnly2(Map dataMap) {
//     return TimingModel(
//       timingName: dataMap[dtmos.timingName],
//       timingString: dataMap[dtmos.timingString],
//     );
//   }
// }

final DefaultTimingModelObjects dtmos = DefaultTimingModelObjects();

class DefaultTimingModelObjects {
  String timingName = "timingName";

  String timingString = "timingString";
  String timings = "timings";
  final String notes = "notes";
  final String refUrlMetadata = "refUrlMetadata";
  final String defaultTimings = "defaultTimings";
  String docRef = docRef0;

  List<TimingModel> foodTimingsListSort(
      List<TimingModel> listDefaultTimingModel) {
    listDefaultTimingModel.sort((a, b) {
      String timeF(TimingModel dtm) {
        return dtm.timingString;
      }

      return timeF(a).compareTo(timeF(b));
    });
    return listDefaultTimingModel;
  }

  String timingStringF(int hour, int min, bool isAM) {
    String ampm = isAM == true ? "am" : "pm";
    String hours = hour > 9 ? hour.toString() : "0${hour.toString()}";
    String mins = min == 0 ? "00" : min.toString();
    return ampm + hours + mins;
  }

  String displayTiming(String timingString) {
    return timingString.substring(2, 4).replaceAll(RegExp(r"^0"), "") +
        "." +
        timingString.substring(4) +
        timingString.substring(0, 2);
  }

  Future<void> initiateDefaultTimingsToFire() async {
    await userDR.collection(settings).doc(defaultTimings).set(
      {unIndexed: listDefaultTimingModels0.map((e) => e.toMap()).toList()},
      SetOptions(merge: true),
    );
  }

  //
  Future<List<TimingModel>> getDefaultTimings() async {
    var l =
        await userDR.collection(settings).doc(defaultTimings).get().then((doc) {
      if (doc.data() != null) {
        List? listMaps = doc.data()![unIndexed];

        if (listMaps != null) {
          return listMaps.map((e) => TimingModel.fromMapOnly2(e)).toList();
        }
      }
    });

    return foodTimingsListSort(l ?? listDefaultTimingModels0);
  }

  TimingModel dtmFromATM(TimingModel atm) {
    return TimingModel(
      timingName: atm.timingName,
      timingString: atm.timingString,
      notes: atm.notes,
      rumm: atm.rumm,
      docRef: null,
    );
  }
}

var listDefaultTimingModels0 = [
  TimingModel(
      timingName: "Breakfast", timingString: dtmos.timingStringF(8, 0, true)),
  TimingModel(
      timingName: "Morning snacks",
      timingString: dtmos.timingStringF(10, 30, true)),
  TimingModel(
      timingName: "Lunch", timingString: dtmos.timingStringF(1, 30, false)),
  TimingModel(
      timingName: "Evening snacks",
      timingString: dtmos.timingStringF(5, 30, false)),
  TimingModel(
      timingName: "Dinner", timingString: dtmos.timingStringF(9, 00, false)),
];
