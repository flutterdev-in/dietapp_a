import 'package:firebase_auth/firebase_auth.dart';

final String userUID = FirebaseAuth.instance.currentUser!.uid;

final User? currentUser = FirebaseAuth.instance.currentUser;
final String userGoogleEmail = FirebaseAuth.instance.currentUser!.email ?? "";
const String docRef0 = "docRef";
const String unIndexed = "unIndexed";
const String youtubeVideoIndentifyURL = "youtube.com/watch?v=";
const String youtubeURL = "youtube.com";
const String mYoutubeCom = "https://m.youtube.com/";

ActiveDietFinalObjects adfos = ActiveDietFinalObjects();

class ActiveDietFinalObjects {
  final String prud = "prud"; // plannedRefUrlMetaData
  final String trud = "trud"; // takenRefUrlMetaData
  final String plannedNotes = "plannedNotes";
  final String takenNotes = "takenNotes";
  final String isPlanned = "isPlanned";
  final String isTaken = "isTaken";
}
