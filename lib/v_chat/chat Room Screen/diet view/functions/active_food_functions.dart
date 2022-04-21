import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/diet%20view/models/active_food_model.dart';

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
