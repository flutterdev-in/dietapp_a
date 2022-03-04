import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/userData/uid.dart';
import 'package:dietapp_a/v_chat/chat_controller.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  @override
  void onInit() async {
    await updateFire(
      isThisChatOpen: true,
    );
    super.onInit();
  }

  @override
  void onClose() async {
    await updateFire(
      isThisChatOpen: false,
    );
    super.onClose();
  }

  Future<void> updateFire({
    required bool isThisChatOpen,
  }) async {

    //1
    if (cc.thisChatPersonUID.value != uid) {
      Map<String, dynamic> map = {
        uid: {"isThisChatOpen": isThisChatOpen}
      };
      await chatRoomC.doc(cc.thisChatDocID.value).set(map, SetOptions(merge: true));
    }

    //2
    WriteBatch batch = FirebaseFirestore.instance.batch();
    await chatRoomC
        .doc(cc.thisChatDocID.value)
        .collection("Messages")
        .where("isChatUploaded", isEqualTo: false)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        Timestamp ts = Timestamp.fromDate(DateTime.now());
        Map<String, dynamic> data = {
          "isChatUploaded": true,
          "docID": document.reference.id,
          "chatTime": ts
        };
        batch.update(document.reference, data);
      });
      return batch.commit();
    });
  }
}
