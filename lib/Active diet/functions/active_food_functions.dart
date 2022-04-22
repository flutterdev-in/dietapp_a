import 'package:dietapp_a/Active%20diet/models/active_food_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';


class ActiveFoodFunctions {
  ActiveFoodModel activeFoodModelFromPlanned(FoodsModelForPlanCreation fm) {
    return ActiveFoodModel(
        isPlanned: true,
        isTaken: false,
        takenTime: null,
        foodName: fm.foodName,
        plannedNotes: fm.notes,
        docRef: fm.docRef,
        takenNotes: null,
        prud: fm.rumm,
        trud: null,
        listProofPicModels: null);
  }
}
