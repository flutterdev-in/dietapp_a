import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:dietapp_a/y_Models/day_model.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';

ActiveModelFromPlannedModel amfpm = ActiveModelFromPlannedModel();

class ActiveModelFromPlannedModel {
  //
  FoodModel foodModel(FoodModel pfm) {
    return FoodModel(
      isCamFood: false,
      foodAddedTime: pfm.foodAddedTime,
      foodTakenTime: null,
      isFolder: null,
      foodName: pfm.foodName,
      notes: pfm.notes,
      rumm: pfm.rumm,
      docRef: null,
    );
  }

  TimingModel timingModel({
    required TimingModel dtm,
  }) {
    return TimingModel(
      timingName: dtm.timingName,
      timingString: dtm.timingString,
      notes: dtm.notes,
      rumm: dtm.rumm,
    );
  }

  DayModel dayModel({
    required DayModel pdm,
    required DateTime date,
  }) {
    return DayModel(
      dayDate: date,
      dayCreatedTime: null,
      dayIndex: null,
      notes: pdm.notes,
      rumm: pdm.rumm,
    );
  }
}
