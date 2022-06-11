import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/v_chat/controllers/chat_room_controller.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';

class ChatRoomFunctions {
  FoodsCollectionModel foodCollectionModelFromPlan(
      FoodsModelForPlanCreation fmp) {
    return FoodsCollectionModel(
      fieldName: fmp.foodName,
      fieldTime: fmp.foodAddedTime,
      isFolder: false,
      notes: fmp.notes,
      rumm: fmp.rumm,
      docRef: fmp.docRef,
    );
  }

  List<Map<String, dynamic>> getFinalList(ChatRoomModel crm) {
    final chatSC = ChatScreenController(crm);
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> selectedList =
        chatSC.selectedList.value;
    List<Map<String, dynamic>> finalList = selectedList.map((snapshot) {
      Map<String, dynamic> map = snapshot.data();

      map[unIndexed][docRef0] = snapshot.reference;
      return map;
    }).toList();

    bool isSingle = selectedList.length == 1;

    String parent = selectedList.first.reference.parent.id;

    QueryDocumentSnapshot<Map<String, dynamic>> snapshot = selectedList.first;
    if (selectedList.first.reference.path.contains(chatTS.foodsCollection)) {
      FoodsCollectionModel fdcm = FoodsCollectionModel.fromMap(snapshot.data());
      if (isSingle) {
        if (fdcm.isFolder && fdcm.rumm != null) {
          chatSC.chatType.value = chatTS.singleWebFolder;
        } else if (fdcm.isFolder) {
          chatSC.chatType.value = chatTS.singleFolder;
        } else if (fdcm.rumm?.isYoutubeVideo ?? false) {
          chatSC.chatType.value = chatTS.singleYoutube;
        } else if (fdcm.rumm != null) {
          chatSC.chatType.value = chatTS.singleWebFood;
        } else {
          chatSC.chatType.value = chatTS.singleCustomFood;
        }
      } else {
        chatSC.chatType.value = chatTS.multiFoodCollection;
      }
    } else if (selectedList.first.reference.path
        .contains(chatTS.dietPlansBeta)) {
      if (parent == dietpbims.dietPlansBeta) {
        chatSC.chatType.value = chatTS.multiPlan;
      } else if (parent == wmfos.weeks) {
        chatSC.chatType.value = chatTS.multiWeek;
      } else if (parent == daymfos.days) {
        chatSC.chatType.value = chatTS.multiDay;
      } else if (parent == dtmos.timings) {
        chatSC.chatType.value = chatTS.multiTiming;
      } else if (parent == fmfpcfos.foods) {
        finalList = finalList
            .map((e) => foodCollectionModelFromPlan(
                    FoodsModelForPlanCreation.fromMap(e))
                .toMap())
            .toList();
        if (isSingle) {
          FoodsModelForPlanCreation fmp =
              FoodsModelForPlanCreation.fromMap(snapshot.data());
          if (fmp.rumm?.isYoutubeVideo ?? false) {
            chatSC.chatType.value = chatTS.singleYoutube;
          } else if (fmp.rumm != null) {
            chatSC.chatType.value = chatTS.singleWebFood;
          } else {
            chatSC.chatType.value = chatTS.singleCustomFood;
          }
        } else {
          chatSC.chatType.value = chatTS.multiFoodCollection;
        }
      }
    }

    return finalList;
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
