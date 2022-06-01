import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/v_chat/constants/chat_const_variables.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
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
            .set(userWelcomeMap, SetOptions(merge: true))
            .then((value) async {
          await userDR.collection(settings).doc(dtmos.defaultTimings).set({
            unIndexed:
                listDefaultTimingModels0.map((e) => e.toMapOnly2()).toList()
          }, SetOptions(merge: true));
        });
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
        var chatRoomModel = ChatRoomModel(
            chatMembers: [userUID, userUID],
            lastChatTime: dateNow,
            lastChatSentBy: userUID,
            lastChatRecdBy: userUID,
            userModel: ChatMemberModel(
                isChatAllowed: true,
                isDietAllowed: true,
                isThisChatOpen: false),
            chatPersonModel: ChatMemberModel(
                isChatAllowed: true,
                isDietAllowed: true,
                isThisChatOpen: false),
            lastChatModel: null,
            chatDR: chatRoomCR.doc(userOwnChatDocID),
            chatPersonUID: userUID);
        await FirebaseFirestore.instance
            .collection(crs.chatRooms)
            .doc(userOwnChatDocID)
            .set(chatRoomModel.toMap(), SetOptions(merge: true))
            .onError((error, stackTrace) {});
      }
    });
  }

  Future<void> createDefaultTimings() async {}
}
