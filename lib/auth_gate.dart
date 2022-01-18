import 'package:dietapp_a/z_HomeScreen/screens/a_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // User is not signed in
            if (!snapshot.hasData) {
              return const SignInScreen(
                providerConfigs: [
                  GoogleProviderConfiguration(
                    clientId: '1:237115759240:android:2ce36ff5e9acc35bfc9d3d',
                  ),
                ],
              );
            }

            // Render your application if authenticated
            return HomeScreen();
          },
        );
      },
    );
  }
}
