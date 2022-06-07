import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:intl/intl.dart';

class ActiveDayModel {
  DateTime dayDate;
  String? notes;
  RefUrlMetadataModel? rumm;
  DocumentReference<Map<String, dynamic>>? docRef;

  //
  ActiveDayModel({
    required this.dayDate,
    this.notes,
    this.rumm,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      admos.dayDate: Timestamp.fromDate(dayDate),
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

 

  factory ActiveDayModel.fromMap(Map docMap) {
    return ActiveDayModel(
      dayDate: docMap[admos.dayDate].toDate(),
      notes: docMap[unIndexed][notes0],
      rumm: rummfos.rummFromRummMap(docMap[unIndexed]?[rummfos.rumm] ?? ""),
      docRef: docMap[unIndexed][docRef0],
    );
  }
}

final ActiveDayModelObjects admos = ActiveDayModelObjects();

class ActiveDayModelObjects {
  final String dayDate = "dayDate";
  final String activeDaysPlan = "activeDaysPlan";
  final DateFormat dayFormat = DateFormat("yyyyMMdd");

  //
  String dayStringFromDate(DateTime date) {
    return dayFormat.format(date);
  }

  //
  DocumentReference<Map<String, dynamic>> activeDayDR(
      DateTime date, String personUID) {
    String dateString = dayStringFromDate(date);
    return FirebaseFirestore.instance
        .collection(users)
        .doc(personUID)
        .collection(admos.activeDaysPlan)
        .doc(dateString);
  }

  //
  DateTime dateFromDayDR(DocumentReference<Map<String, dynamic>> dayDR) {
    return DateTime.parse(dayDR.id);
  }

  //
  DateTime dateZeroTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
