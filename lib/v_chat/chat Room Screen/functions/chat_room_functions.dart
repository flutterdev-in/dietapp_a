import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/v_chat/controllers/chat_room_controller.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';
import 'package:dietapp_a/y_Models/food_model.dart';

class ChatRoomFunctions {
  FoodModel foodCollectionModelFromPlan(FoodModel fmp) {
    return FoodModel(
      foodName: fmp.foodName,
      foodAddedTime: fmp.foodAddedTime,
      foodTakenTime: null,
      isCamFood: null,
      isFolder: false,
      notes: fmp.notes,
      rumm: fmp.rumm,
      docRef: fmp.docRef,
    );
  }


  Future<bool> isChatPersonOnChat(ChatRoomModel crm) async {
    bool isChatOpen = false;
    await crm.chatDR.get().then((ds) async {
      if (ds.exists && ds.data() != null) {
        var crmNew = ChatRoomModel.fromMap(ds.data()!);
        if (crmNew.chatPersonModel.isThisChatOpen) {
          await FirebaseFirestore.instance
              .collection(users)
              .doc(crm.chatPersonUID)
              .get()
              .then((ds) {
            if (ds.exists && ds.data() != null) {
              var uwm = UserWelcomeModel.fromMap(ds.data()!);
              if (uwm.isActive) {
                isChatOpen = true;
              }
            }
          });
        }
      }
    });
    return isChatOpen;
  }
}
