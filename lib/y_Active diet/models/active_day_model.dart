import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:intl/intl.dart';

class ActiveDayModel {
  DateTime dayDate;
  String? dayName;
  bool isPlanned;

  bool? isTaken;
  String? plannedNotes;
  String? takenNotes;
  RefUrlMetadataModel? prud;
  RefUrlMetadataModel? trud;
  DocumentReference<Map<String, dynamic>>? docRef;

  //
  ActiveDayModel({
    required this.dayDate,
    required this.isPlanned,
    required this.dayName,
    this.isTaken,
    this.plannedNotes,
    this.takenNotes,
    this.prud,
    this.trud,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      admos.dayDate: Timestamp.fromDate(dayDate),
      unIndexed: {
        adfos.isPlanned: isPlanned,
      }
    };
    Map<String, dynamic> nullChaeckValues = {
      admos.dayName: dayName,
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

  factory ActiveDayModel.fromMap(Map docMap) {
    return ActiveDayModel(
      dayDate: docMap[admos.dayDate].toDate(),
      dayName: docMap[admos.dayDate],
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

final ActiveDayModelObjects admos = ActiveDayModelObjects();

class ActiveDayModelObjects {
  final String dayDate = "dayDate";
  final String dayName = "dayName";
  final String refPlanDR = "refPlanDR";
  final String activeDaysPlan = "activeDaysPlan";

  String dayStringFromDate(DateTime date) {
    return DateFormat("yyyyMMdd").format(date);
  }

  //
  DocumentReference<Map<String, dynamic>> activeDayDR(DateTime date) {
    String dateString = dayStringFromDate(date);
    
    return userDR.collection(admos.activeDaysPlan).doc(dateString);
  }
}
