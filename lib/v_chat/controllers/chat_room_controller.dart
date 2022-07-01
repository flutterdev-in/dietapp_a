import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/hive%20Boxes/boxes.dart';
import 'package:dietapp_a/v_chat/controllers/chat_room_variables.dart';
import 'package:dietapp_a/v_chat/diet%20Room%20Screen/_diet_room_controller.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  // final docList = RxList<DocumentReference<Map<String, dynamic>>>([]).obs;

  final ChatRoomModel crm;
  ChatScreenController(this.crm);

  @override
  void onInit() async {
    drc.calendarDate.value = DateTime.now();
    csv.replyMessageModel.value = dummyMM;

    updateFire(
      isThisChatOpen: true,
    );
    super.onInit();
  }

  @override
  void onClose() async {
    csv.replyMessageModel.value = dummyMM;
    drc.calendarDate.value = DateTime.now();
    updateFire(
      isThisChatOpen: false,
    );
    super.onClose();
  }

  Future<void> updateFire({
    required bool isThisChatOpen,
  }) async {
    //1
    var isChat = boxIndexes.get(crm.chatPersonUID) ?? false;
    if (isChat == true) {
      await crm.chatDR.update(
          {"$unIndexed.$userUID.${crs.isThisChatOpen}": isThisChatOpen});
      //2

      await crm.chatDR
          .collection(crs.chats)
          .where(mmos.chatRecdBy, isEqualTo: userUID)
          .where(mmos.recieverSeenTime, isNull: true)
          .get()
          .then((querySnapshot) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> document
            in querySnapshot.docs) {
          document.reference.update({
            "$unIndexed.${mmos.docRef}": document.reference,
            mmos.recieverSeenTime: Timestamp.fromDate(DateTime.now()),
          });
        }
      });
    }
  }
}
