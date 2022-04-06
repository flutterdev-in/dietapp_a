import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';

import 'package:dietapp_a/v_chat/constants/chat_const_variables.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/bottom_sheet/gf_bottom_sheet.dart';

ChatScreenController chatSC = ChatScreenController();

class ChatScreenController extends GetxController {
  final bottomCont = GFBottomSheetController();
  final docList = RxList<DocumentReference<Map<String, dynamic>>>([]).obs;
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
    Map<String, dynamic> map = {
      userUID: {crs.isThisChatOpen: isThisChatOpen}
    };
    await chatRoomC.doc(thisChatDocID.value).update(map);
    //2
    WriteBatch batch = FirebaseFirestore.instance.batch();
    await chatRoomC
        .doc(thisChatDocID.value)
        .collection(crs.chats)
        .where(mms.chatRecdBy, isEqualTo: userUID)
        .where(mms.recieverSeenTime, isEqualTo: null)
        .get()
        .then((querySnapshot) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in querySnapshot.docs) {
        batch.update(document.reference, {
          mms.docID: document.reference.id,
          mms.recieverSeenTime: Timestamp.fromDate(DateTime.now()),
        });
      }
    });

    await chatRoomC
        .doc(thisChatDocID.value)
        .collection(crs.chats)
        .where(mms.docID, isEqualTo: null)
        .get()
        .then((querySnapshot) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in querySnapshot.docs) {
        batch.update(document.reference, {
          mms.docID: document.reference.id,
        });
      }
      return batch.commit();
    });
  }
}
