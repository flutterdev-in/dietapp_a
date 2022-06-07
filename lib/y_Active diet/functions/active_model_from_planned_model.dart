import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_food_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';

ActiveModelFromPlannedModel amfpm = ActiveModelFromPlannedModel();

class ActiveModelFromPlannedModel {
  //
  ActiveFoodModel foodModel(FoodsModelForPlanCreation pfm) {
    return ActiveFoodModel(
      isCamFood: false,
      foodAddedTime: pfm.foodAddedTime,
      takenTime: null,
      foodName: pfm.foodName,
      notes: pfm.notes,
      rumm: pfm.rumm,
      docRef: null,
    );
  }

  ActiveTimingModel timingModel({
    required DefaultTimingModel dtm,
  }) {
    return ActiveTimingModel(
      timingName: dtm.timingName,
      timingString: dtm.timingString,
      notes: dtm.notes,
      rumm: dtm.rumm,
    );
  }

  ActiveDayModel dayModel({
    required DayModel pdm,
    required DateTime date,
  }) {
    return ActiveDayModel(
      dayDate: date,
      notes: pdm.notes,
      rumm: pdm.rumm,
    );
  }
}
