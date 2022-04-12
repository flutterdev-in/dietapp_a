import 'package:firebase_auth/firebase_auth.dart';

final String userUID = FirebaseAuth.instance.currentUser!.uid;

final User? currentUser = FirebaseAuth.instance.currentUser;
final String userGoogleEmail = FirebaseAuth.instance.currentUser!.email ?? "";
const String docRef0 = "docRef";
const String unIndexed = "unIndexed";
