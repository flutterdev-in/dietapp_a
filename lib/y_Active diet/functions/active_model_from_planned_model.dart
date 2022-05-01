import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_food_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_plan_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';

ActiveModelFromPlannedModel amfpm = ActiveModelFromPlannedModel();

class ActiveModelFromPlannedModel {
  //
  ActiveFoodModel foodModel(FoodsModelForPlanCreation pfm) {
    return ActiveFoodModel(
        foodTypeCamPlanUp: afmos.plan,
        isTaken: false,
        foodAddedTime: pfm.foodAddedTime.toDate(),
        takenTime: null,
        foodName: pfm.foodName,
        plannedNotes: pfm.notes,
        docRef: pfm.docRef,
        takenNotes: null,
        prud: pfm.rumm,
        trud: null,
        );
  }

  ActiveTimingModel timingModel({
    required DefaultTimingModel dtm,
 
  }) {
    return ActiveTimingModel(
      timingName: dtm.timingName,
      timingString: dtm.timingString,
     
      isPlanned: true,
      plannedNotes: dtm.notes,
      prud: dtm.rumm,
    );
  }

  ActiveDayModel dayModel({
    required DayModel pdm,
    required DateTime date,
  }) {
    return ActiveDayModel(
      dayDate: date,
      isPlanned: true,
      dayName: pdm.dayName,
      plannedNotes: pdm.notes,
      prud: pdm.rumm,
    );
  }

  ActivePlanModel planModel({
    required DietPlanBasicInfoModel dpm,
    required DateTime startDate,
    required DateTime? endTime,
  }) {
    return ActivePlanModel(
      planStartDate: startDate,
      lastPlanningDate: endTime,
      planName: dpm.planName,
      isPlanned: true,
      plannedNotes: dpm.notes,
      prud: dpm.rumm,
    );
  }
}
