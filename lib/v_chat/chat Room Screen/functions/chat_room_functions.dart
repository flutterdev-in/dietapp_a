import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/x_FCM/fcm_model.dart';
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

  static Future<FcmModel> getFcmModel(ChatRoomModel crm) async {
    var ff = FcmModel(
        fcmBody: "New message",
        chatImg: null,
        recieverToken: "",
        recieverName: "",
        recieverProfileImgUrl: null);
    await FirebaseFirestore.instance
        .collection(users)
        .doc(crm.chatPersonUID)
        .get()
        .then((ds) async {
      if (ds.exists && ds.data() != null) {
        var uwm = UserWelcomeModel.fromMap(ds.data()!);

        ff.recieverToken = uwm.fcmToken ?? "";
        ff.recieverProfileImgUrl = uwm.photoURL;
        ff.recieverName = uwm.displayName;
        if (uwm.isActive) {
          await crm.chatDR.get().then((ds) async {
            if (ds.exists && ds.data() != null) {
              var crmNew = ChatRoomModel.fromMap(ds.data()!);
              if (crmNew.chatPersonModel.isThisChatOpen) {
                ff.isRecieverOnChat = true;
              }
            }
          });
        }
      }
    });
    return ff;
  }
}
