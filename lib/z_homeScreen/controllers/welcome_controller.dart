import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
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
}
