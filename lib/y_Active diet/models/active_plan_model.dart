import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:intl/intl.dart';

class ActivePlanModel {
  DateTime planStartDate;
  DateTime? lastPlanningDate;
  String planName;
  bool isPlanned;
  bool? isTaken;
  String? plannedNotes;
  String? takenNotes;
  RefUrlMetadataModel? prud;
  RefUrlMetadataModel? trud;
  DocumentReference<Map<String, dynamic>>? docRef;

  //
  ActivePlanModel({
    required this.planStartDate,
    required this.lastPlanningDate,
    required this.planName,
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
      apmos.planStartDate: Timestamp.fromDate(planStartDate),
      apmos.planName: planName,
      unIndexed: {
        adfos.isPlanned: isPlanned,
      }
    };
    Map<String, dynamic> nullChaeckValues = {
      apmos.lastPlanningDate: lastPlanningDate != null
          ? Timestamp.fromDate(lastPlanningDate!)
          : null,
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

  factory ActivePlanModel.fromMap(Map docMap) {
    return ActivePlanModel(
      planStartDate: docMap[apmos.planStartDate].toDate(),
      planName: docMap[apmos.planName],
      lastPlanningDate: docMap[unIndexed][apmos.lastPlanningDate]?.toDate(),
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

final ActivePlanModelObjects apmos = ActivePlanModelObjects();

class ActivePlanModelObjects {
  final String planStartDate = "planStartDate";
  final String lastPlanningDate = "lastPlanningDate";
  final String planName = "planName";
  final String activeDietPlansInfo = "activeDietPlansInfo";

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
