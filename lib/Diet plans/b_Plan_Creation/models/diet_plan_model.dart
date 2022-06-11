import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';

class DietPlanBasicInfoModel {
  String planName;
  bool isWeekWisePlan;
  Timestamp planCreationTime;
  RefUrlMetadataModel? rumm;
  String? notes;
  List<TimingModel> planDefaulTimings;
  DocumentReference<Map<String, dynamic>>? docRef;

  //
  DietPlanBasicInfoModel({
    required this.planName,
    required this.isWeekWisePlan,
    required this.notes,
    required this.planCreationTime,
    required this.rumm,
    required this.planDefaulTimings,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      dietpbims.planName: planName,
      dietpbims.planCreationTime: planCreationTime,
      dietpbims.isWeekWisePlan: isWeekWisePlan,
      unIndexed: {}
    };
    Map<String, dynamic> nullChaeckValues = {
      dietpbims.notes: notes,
      rummfos.rumm: rumm?.toMap(),
      dietpbims.planDefaultTimings:
          planDefaulTimings.map((e) => e.toMap()).toList(),
      dietpbims.docRef: docRef,
    };

    nullChaeckValues.forEach((key, value) {
      if (value != null) {
        returnMap[unIndexed][key] = value;
      }
    });

    return returnMap;
  }

  factory DietPlanBasicInfoModel.fromMap(Map mainPlanBasicMap) {
    return DietPlanBasicInfoModel(
      planName: mainPlanBasicMap[dietpbims.planName],
      isWeekWisePlan: mainPlanBasicMap[dietpbims.isWeekWisePlan],
      planCreationTime: mainPlanBasicMap[dietpbims.planCreationTime],
      notes: mainPlanBasicMap[unIndexed][dietpbims.notes],
      rumm: rummfos.rummFromRummMap(mainPlanBasicMap[unIndexed][rummfos.rumm]),
      planDefaulTimings: dietpbims
          .listDFTM(mainPlanBasicMap[unIndexed][dietpbims.planDefaultTimings]),
      docRef: mainPlanBasicMap[unIndexed][dietpbims.docRef],
    );
  }
}

DietPlanBasicInfoModelStrings dietpbims = DietPlanBasicInfoModelStrings();

class DietPlanBasicInfoModelStrings {
  final String dietPlansBeta = "dietPlansBeta";
  final String planName = "planName";
  final String isWeekWisePlan = "isDayWisePlan";
  final String planCreationTime = "planCreationTime";
  final String notes = "notes";
  final String refURL = "refURL";
  final String planDefaultTimings = "planDefaultTimings";

  String docRef = docRef0;

  List<TimingModel> listDFTM(List list) {
    return list.map((e) {
      return TimingModel.fromMap(e);
    }).toList();
  }
}
