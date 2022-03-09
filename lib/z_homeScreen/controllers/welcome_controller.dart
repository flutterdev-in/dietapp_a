import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/my%20foods/screens/a_food%20timings/models/food_timing_model.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/v_chat/constants/chat_const_variables.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  @override
  void onInit() async {
    await createUserDoc();
    await createChatDoc();
    await createFoodTimings();
    super.onInit();
  }

  Future<void> createUserDoc() async {
    await FirebaseFirestore.instance
        .collection(uss.users)
        .doc(userUID)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (!documentSnapshot.exists) {
        String userID0 = "@${userGoogleEmail.replaceAll("@gmail.com", "")}";
        var userWelcomeMap = UserWelcomeModel(
          firebaseUID: currentUser!.uid,
          googleEmail: currentUser!.email ?? "guestuser@guest.com",
          userID: userID0,
          photoURL: currentUser!.photoURL,
          displayName: currentUser!.displayName ?? "Anonymous User",
          activeAt: Timestamp.fromDate(DateTime.now()),
          inactiveAt: Timestamp.fromDate(DateTime.now()),
        ).toMap();
        await FirebaseFirestore.instance
            .collection(uss.users)
            .doc(userUID)
            .set(userWelcomeMap, SetOptions(merge: true));
      }
    });
  }

  Future<void> createChatDoc() async {
    await FirebaseFirestore.instance
        .collection(crs.chatRooms)
        .doc(userOwnChatDocID)
        .get()
        .then((docSnap) async {
      if (!docSnap.exists) {
        List<String> chatDocIDList = [userUID, userUID];
        chatDocIDList.sort();
        Map<String, dynamic> chatIDMap = {
          crs.chatMembers: chatDocIDList,
          crs.chatDocID: userOwnChatDocID,
          userUID: {crs.isThisChatOpen: false}
        };
        await FirebaseFirestore.instance
            .collection(crs.chatRooms)
            .doc(userOwnChatDocID)
            .set(chatIDMap, SetOptions(merge: true))
            .onError((error, stackTrace) {});
      }
    });
  }

  Future<void> createFoodTimings() async {
    await FirebaseFirestore.instance
        .collection(uss.users)
        .doc(userUID)
        .collection("userDocuments")
        .doc("foodTimings")
        .get()
        .then((docSnap) async {
      if (!docSnap.exists) {
        List<Map<String, dynamic>> foodTimingsList = [
          FoodTimingModel(
                  name: "Breakfast",
                  hours: 8,
                  mins: 0,
                  deviation: 45,
                  isAm: true)
              .toMap(),
          FoodTimingModel(
                  name: "Morning snaks",
                  hours: 10,
                  mins: 30,
                  deviation: 30,
                  isAm: true)
              .toMap(),
          FoodTimingModel(
                  name: "Lunch", hours: 1, mins: 30, deviation: 30, isAm: false)
              .toMap(),
          FoodTimingModel(
                  name: "Evening snaks",
                  hours: 5,
                  mins: 30,
                  deviation: 45,
                  isAm: false)
              .toMap(),
          FoodTimingModel(
                  name: "Dinner",
                  hours: 8,
                  mins: 30,
                  deviation: 45,
                  isAm: false)
              .toMap(),
        ];
        await docSnap.reference.set({"foodTimingsList": foodTimingsList},
            SetOptions(merge: true)).onError((error, stackTrace) {});
      }
    });
  }
}
