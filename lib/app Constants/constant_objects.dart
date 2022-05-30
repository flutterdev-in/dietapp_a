import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

final String userUID = FirebaseAuth.instance.currentUser!.uid;

final User? currentUser = FirebaseAuth.instance.currentUser;
final String userGoogleEmail = FirebaseAuth.instance.currentUser!.email ?? "";
const String docRef0 = "docRef";
const String unIndexed = "unIndexed";
const String youtubeVideoIndentifyURL = "youtube.com/watch?v=";
const String youtubeURL = "youtube.com";
const String mYoutubeCom = "https://m.youtube.com/";
final Timestamp timestampNow = Timestamp.fromDate(DateTime.now());
final DateTime dateNow = DateTime.now();
final ImagePicker imagePicker = ImagePicker();
final isLoading = false.obs;
const String settings = "settings";
const String users = "Users";
final CollectionReference<Map<String, dynamic>> usersCollection =
    FirebaseFirestore.instance.collection(users);

double mdWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double mdHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

ActiveDietFinalObjects adfos = ActiveDietFinalObjects();

class ActiveDietFinalObjects {
  final String prud = "prud"; // plannedRefUrlMetaData
  final String trud = "trud"; // takenRefUrlMetaData
  final String plannedNotes = "plannedNotes";
  final String takenNotes = "takenNotes";
  final String isPlanned = "isPlanned";
  final String isTaken = "isTaken";
}
