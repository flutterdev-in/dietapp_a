import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';

//Strings
Stream<DocumentSnapshot> userDS0 =
    FirebaseFirestore.instance.collection(uss.users).doc(userUID).snapshots();
Stream<DocumentSnapshot> userDS =
    FirebaseFirestore.instance.collection(uss.users).doc(userUID).snapshots();

final DocumentReference<Map<String, dynamic>> userDR =
    FirebaseFirestore.instance.collection(uss.users).doc(userUID);

final CollectionReference chatRoomC =
    FirebaseFirestore.instance.collection(crs.chatRooms);

DocumentReference<Map<String, dynamic>> fireDR(String docPath) {
  return FirebaseFirestore.instance.doc(docPath);
}

final DocumentReference<Map<String, dynamic>> defaultTimingsDR =
    userDR.collection(settings).doc(dtmos.defaultTimings);

final DocumentReference<Map<String, dynamic>> dietViewMembersDR =
    userDR.collection(settings).doc("dietViewMembers");
