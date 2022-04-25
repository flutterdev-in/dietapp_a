import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:intl/intl.dart';

class ActiveTimingModel {
  String timingName;
  String timingString;
  DateTime timingDate;
  bool isPlanned;
  bool? isTaken;
  String? plannedNotes;
  String? takenNotes;
  RefUrlMetadataModel? prud;
  RefUrlMetadataModel? trud;
  DocumentReference<Map<String, dynamic>>? docRef;

  //
  ActiveTimingModel({
    required this.timingName,
    required this.timingString,
    required this.timingDate,
    required this.isPlanned,
    this.isTaken,
    this.plannedNotes,
    this.takenNotes,
    this.prud,
    this.trud,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      atmos.timingName: timingName,
      atmos.timingDate: Timestamp.fromDate(timingDate),
      unIndexed: {
        adfos.isPlanned: isPlanned,
      }
    };
    Map<String, dynamic> nullChaeckValues = {
      adfos.isTaken: isTaken,
      adfos.plannedNotes: plannedNotes,
      adfos.takenNotes: takenNotes,
      adfos.prud: prud?.toMap(),
      adfos.trud: trud?.toMap(),
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
    Timestamp timeDate = docMap[unIndexed][atmos.timingDate] ??
        Timestamp.fromDate(DateTime.now());
    return ActiveTimingModel(
      timingName: docMap[atmos.timingName] ?? "",
      timingDate: timeDate.toDate(),
      timingString: atmos.timingStringFromDateTime(timeDate),
      isPlanned: docMap[unIndexed][adfos.isPlanned],
      isTaken: docMap[unIndexed][adfos.isTaken],
      plannedNotes: docMap[unIndexed][adfos.plannedNotes],
      takenNotes: docMap[unIndexed][adfos.takenNotes],
      prud: rummfos.rummFromRummMap(docMap[unIndexed][adfos.prud]),
      trud: rummfos.rummFromRummMap(docMap[unIndexed][adfos.trud]),
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

  Timestamp timeDateFromDayTime(DateTime dateTime, String timeString) {
    String dayString = DateFormat("yMd").format(dateTime);
    timeString = timeString.toUpperCase();
    DateTime dt = DateFormat('yMd h:mma').parse("$dayString $timeString");
    return Timestamp.fromDate(dt);
  }
}
