import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/assets/assets.dart';
import 'package:dietapp_a/intro_view.dart';
import 'package:dietapp_a/main_screen_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return
              // const SignInScreen(
              //   providerConfigs: [
              //     GoogleProviderConfiguration(
              //         clientId: "1:237115759240:android:57b787e3a03aca69fc9d3d"),
              //   ],
              // );
              const LoginView();
        }
        userUID = FirebaseAuth.instance.currentUser!.uid;
        return const ManinScreenManager();

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
      body: Column(
        children: [
          SizedBox(height: mdHeight(context) * 3 / 4, child: const IntroView()),
          SizedBox(
            height: mdHeight(context) * 1 / 4,
            child: Center(
              child: InkWell(
                child: Card(
                  elevation: 2.1,
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 5),
                        SvgPicture.asset(Assets().googleIcon),
                        const Text(
                          "  Continue with Google",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  await login();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> login() async {
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
