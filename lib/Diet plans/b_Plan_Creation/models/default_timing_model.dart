import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';

class DefaultTimingModel {
  String timingName;
  String timingString;
  String? notes;
  RefUrlMetadataModel? rumm;
  DocumentReference? docRef;

  //
  DefaultTimingModel({
    required this.timingName,
    required this.timingString,
    this.notes,
    this.rumm,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    return {
      dtmos.timingName: timingName,
      dtmos.timingString: timingString,
      unIndexed: {
        dtmos.notes: notes,
        rummfos.rumm: rumm?.toMap(),
        dtmos.docRef: docRef,
      }
    };
  }

  factory DefaultTimingModel.fromMap(Map dataMap) {
    return DefaultTimingModel(
      timingName: dataMap[dtmos.timingName],
      timingString: dataMap[dtmos.timingString],
      notes: dataMap[unIndexed][dtmos.notes],
      rumm: rummfos.rummFromRummMap(dataMap[unIndexed][rummfos.rumm]),
      docRef: dataMap[unIndexed][dtmos.docRef],
    );
  }
}

final DefaultTimingModelObjects dtmos = DefaultTimingModelObjects();

class DefaultTimingModelObjects {
  String timingName = "timingName";

  String timingString = "timingString";
  String timings = "timings";
  final String notes = "notes";
  final String refUrlMetadata = "refUrlMetadata";
  String docRef = docRef0;

  List<DefaultTimingModel> foodTimingsListSort(
      List<DefaultTimingModel> listDefaultTimingModel) {
    listDefaultTimingModel.sort((a, b) {
      String timeF(DefaultTimingModel dtm) {
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
}
