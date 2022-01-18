import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';

class WelcomeController extends GetxController {
  @override
  void onInit() async {
    User user = FirebaseAuth.instance.currentUser!;
    var userWelcomeMap = UserWelcomeModel(
      firebaseUID: user.uid,
      googleDisplayName: user.displayName,
      googleEmail: user.email,
      googlePhotoURL: user.photoURL,
      googleIsEmailVerified: user.emailVerified,
      googleIsAnonymous: user.isAnonymous,
      googlePhoneNumber: user.phoneNumber ?? "",
      googleCreationTime: user.metadata.creationTime,
      googleLastSignInTime: user.metadata.lastSignInTime,
      photoURL: user.photoURL,
      displayName: user.displayName,
      userID: user.email,
    ).toMap();
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (!documentSnapshot.exists) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user.uid)
            .set(userWelcomeMap);
      }
    });
    super.onInit();
  }

  void logout() async {
    await GoogleSignIn().disconnect();
    await FirebaseAuth.instance.signOut();
  }
}
