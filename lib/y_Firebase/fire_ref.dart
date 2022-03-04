import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Strings

FireStrings fs = FireStrings();
String fuid = FirebaseAuth.instance.currentUser!.uid;

final Stream<DocumentSnapshot> userDS =
    FirebaseFirestore.instance.collection(fs.usersC).doc(fuid).snapshots();

final DocumentReference userDR =
    FirebaseFirestore.instance.collection(fs.usersC).doc(fuid);

final DocumentReference userActivityDR = FirebaseFirestore.instance
    .collection(fs.usersC)
    .doc(fuid)
    .collection(fs.userDocumentsC)
    .doc(fs.userActivityD);
final CollectionReference chatRoomC =
    FirebaseFirestore.instance.collection(crs.chatRooms);

class FireStrings {
  //Collections
  String usersC = "Users";

  //# Users Collection
  //## User Sub collections
  String userDocumentsC = "UserDocuments";
  //## User Sub documents
  String userActivityD = "userActivity";
}
