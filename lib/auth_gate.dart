import 'package:dietapp_a/main_screen_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return const LoginView();

          // const SignInScreen(
          //   providerConfigs: [
          //     GoogleProviderConfiguration(
          //       clientId: '1:237115759240:android:57b787e3a03aca69fc9d3d',
          //     ),
          //   ],
          //   showAuthActionSwitch: false,
          // );
        } else {
          return const ManinScreenManager();
        }

        // Render your application if authenticated
      },
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: context.width),
            child: ElevatedButton(
              child: const Text(
                "Sign In with Google",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              onPressed: () {
                login();
              },
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    try {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await firebaseAuth.signInWithCredential(oAuthCredential);

      Get.back();
    } catch (error) {
      Get.snackbar("Error", "$error");
    }
  }
}

// class LoginController extends GetxController {
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();

//   void login() async {
//     GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

//     try {
//       GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount!.authentication;

//       OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );

//       await firebaseAuth.signInWithCredential(oAuthCredential);

//       Get.back();
//     } catch (error) {
//       Get.snackbar("Error", "$error");
//     }
//   }
// }
