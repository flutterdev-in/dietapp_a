import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:intl/intl.dart';

class TimingModel {
  String timingName;
  String timingString;
  String? notes;
  RefUrlMetadataModel? rumm;
  DocumentReference<Map<String, dynamic>>? docRef;

  //
  TimingModel({
    required this.timingName,
    required this.timingString,
    this.notes,
    this.rumm,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      tmos.timingName: timingName,
      tmos.timingString: timingString,
      unIndexed: {}
    };
    Map<String, dynamic> nullChaeckValues = {
      notes0: notes,
      rummfos.rumm: rumm?.toMap(),
      tmos.docRef: docRef,
    };
    nullChaeckValues.forEach((key, value) {
      if (value != null) {
        returnMap[unIndexed][key] = value;
      }
    });

    return returnMap;
  }

  Map<String, dynamic> toMapOnly2() {
    return {
      tmos.timingName: timingName,
      tmos.timingString: timingString,
    };
  }

  factory TimingModel.fromMap(Map dataMap) {
    return TimingModel(
      timingName: dataMap[tmos.timingName],
      timingString: dataMap[tmos.timingString],
      notes: dataMap[unIndexed][notes0],
      rumm: rummfos.rummFromRummMap(dataMap[unIndexed][rummfos.rumm]),
      docRef: dataMap[unIndexed][tmos.docRef],
    );
  }
  factory TimingModel.fromMapOnly2(Map dataMap) {
    return TimingModel(
      timingName: dataMap[tmos.timingName],
      timingString: dataMap[tmos.timingString],
    );
  }
}

final TimingModelObjects tmos = TimingModelObjects();

class TimingModelObjects {
  String timingName = "timingName";

  String timingString = "timingString";
  String timings = "timings";
  
  final String refUrlMetadata = "refUrlMetadata";
  final String defaultTimings = "defaultTimings";
  String docRef = docRef0;


// 
String timingFireStringFromDateTime(DateTime date) {
    String s = DateFormat("ahhmm").format(date).toLowerCase();
    return s;
  }

  //
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
}

var listDefaultTimingModels0 = [
  TimingModel(
      timingName: "Breakfast", timingString: tmos.timingStringF(8, 0, true)),
  TimingModel(
      timingName: "Morning snacks",
      timingString: tmos.timingStringF(10, 30, true)),
  TimingModel(
      timingName: "Lunch", timingString: tmos.timingStringF(1, 30, false)),
  TimingModel(
      timingName: "Evening snacks",
      timingString: tmos.timingStringF(5, 30, false)),
  TimingModel(
      timingName: "Dinner", timingString: tmos.timingStringF(9, 00, false)),
];
