import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/assets/assets.dart';
import 'package:dietapp_a/dartUtilities/app_updater.dart';
import 'package:dietapp_a/intro_view.dart';
import 'package:dietapp_a/main_screen_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    appUpdater.checkAndUpdate(context);
    super.initState();
  }

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
    var isPressed = false.obs;
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.8, child: const IntroView()),
            SizedBox(
              height: Get.height * 0.2,
              child: Center(
                child: InkWell(
                  child: Obx(() => Card(
                        color: Colors.black12,
                        elevation: isPressed.value ? 0 : 4,
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
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )),
                  onTap: () async {
                    isPressed.value = true;
                    await Future.delayed(const Duration(milliseconds: 150));
                    isPressed.value = false;
                    await login();
                  },
                ),
              ),
            ),
          ],
        ),
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
      Get.snackbar("Error while login", "Please try again");
    }
  }
}
