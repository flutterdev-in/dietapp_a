import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';

class DietPlanBasicInfoModel {
  String planName;

  Timestamp? planCreationTime;
  RefUrlMetadataModel? rumm;
  String? notes;
  List<DefaultTimingModel> defaultTimings;
  List<DefaultTimingModel> defaultTimings0;
  DocumentReference? docRef;

  //
  DietPlanBasicInfoModel({
    required this.planName,
    required this.notes,
    required this.planCreationTime,
    required this.rumm,
    required this.defaultTimings,
    required this.defaultTimings0,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    return {
      dietpbims.planName: planName,
      dietpbims.planCreationTime: planCreationTime,
      unIndexed: {
        dietpbims.notes: notes,
        rummfos.rumm: rumm?.toMap(),
        dietpbims.defaultTimings: defaultTimings.map((e) => e.toMap()).toList(),
        dietpbims.defaultTimings0:
            defaultTimings0.map((e) => e.toMap()).toList(),
        dietpbims.docRef: docRef,
      }
    };
  }

  factory DietPlanBasicInfoModel.fromMap(Map mainPlanBasicMap) {
    return DietPlanBasicInfoModel(
      planName: mainPlanBasicMap[dietpbims.planName],
      planCreationTime: mainPlanBasicMap[dietpbims.planCreationTime],
      notes: mainPlanBasicMap[unIndexed][dietpbims.notes],
      rumm: rummfos.rummFromRummMap(mainPlanBasicMap[unIndexed][rummfos.rumm]),
      defaultTimings: dietpbims
          .listDFTM(mainPlanBasicMap[unIndexed][dietpbims.defaultTimings]),
      defaultTimings0: dietpbims
          .listDFTM(mainPlanBasicMap[unIndexed][dietpbims.defaultTimings0]),
      docRef: mainPlanBasicMap[unIndexed][dietpbims.docRef],
    );
  }
}

DietPlanBasicInfoModelStrings dietpbims = DietPlanBasicInfoModelStrings();

class DietPlanBasicInfoModelStrings {
  final String dietPlansBeta = "dietPlansBeta";
  final String planName = "planName";

  final String planCreationTime = "planCreationTime";
  final String notes = "notes";
  final String refURL = "refURL";
  final String defaultTimings = "defaultTimings";
  final String defaultTimings0 = "defaultTimings0";
  String docRef = docRef0;

  List<DefaultTimingModel> listDFTM(List list) {
    return list.map((e) {
      return DefaultTimingModel.fromMap(e);
    }).toList();
  }
}
