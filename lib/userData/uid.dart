import 'package:firebase_auth/firebase_auth.dart';

class FireUID {
  String uid = FirebaseAuth.instance.currentUser!.uid;
}
