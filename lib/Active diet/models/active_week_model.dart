import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:intl/intl.dart';

class ActiveWeekModel {
  Timestamp weekStartDate;
  String weekName;
  bool isPlanned;
  bool? isTaken;
  String? plannedNotes;
  String? takenNotes;
  RefUrlMetadataModel? prud;
  RefUrlMetadataModel? trud;
  DocumentReference<Map<String, dynamic>>? docRef;

  //
  ActiveWeekModel({
    required this.weekStartDate,
    required this.isPlanned,
    required this.weekName,
    this.isTaken,
    this.plannedNotes,
    this.takenNotes,
    this.prud,
    this.trud,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      awmos.weekStartDate: weekStartDate,
      unIndexed: {
        adfos.isPlanned: isPlanned,
      }
    };
    Map<String, dynamic> nullChaeckValues = {
      adfos.isTaken: isTaken,
      adfos.plannedNotes: plannedNotes,
      adfos.takenNotes: takenNotes,
      adfos.prud: prud,
      adfos.trud: trud,
      docRef0: docRef,
    };

    nullChaeckValues.forEach((key, value) {
      if (value != null) {
        returnMap[unIndexed][key] = value;
      }
    });

    return returnMap;
  }

  factory ActiveWeekModel.fromMap(Map docMap) {
    Timestamp weekStartDate0 = docMap[awmos.weekStartDate] ?? DateTime.now();
    return ActiveWeekModel(
      weekStartDate: weekStartDate0,
      weekName: awmos.weekNameFromTimestamp(weekStartDate0),
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

final ActiveWeekModelObjects awmos = ActiveWeekModelObjects();

class ActiveWeekModelObjects {
  final String weekStartDate = "weekStartDate";
  final String weekName = "weekName";

  String weekNameFromTimestamp(Timestamp weekStartDate0) {
    DateTime wsd = weekStartDate0.toDate();
    DateTime wed = wsd.add(const Duration(days: 7));

    if (DateFormat("MMM").format(wsd) == DateFormat("MMM").format(wed)) {
      return DateFormat("MMM d").format(wsd) +
          "-" +
          DateFormat("d").format(wed);
    } else {
      return DateFormat("MMM d").format(wsd) +
          "-" +
          DateFormat("MMM d").format(wed);
    }
  }
}
