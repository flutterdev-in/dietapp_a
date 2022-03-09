import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';

//Strings
Stream<DocumentSnapshot> userDS0 =
    FirebaseFirestore.instance.collection(uss.users).doc(userUID).snapshots();
Stream<DocumentSnapshot> userDS =
    FirebaseFirestore.instance.collection(uss.users).doc(userUID).snapshots();

final DocumentReference userDR =
    FirebaseFirestore.instance.collection(uss.users).doc(userUID);

final CollectionReference chatRoomC =
    FirebaseFirestore.instance.collection(crs.chatRooms);

