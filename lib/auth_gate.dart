import 'package:dietapp_a/main_screen_manager.dart';
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
        // User is not signed in
        if (!snapshot.hasData) {
          return const SignInScreen(
            providerConfigs: [
              GoogleProviderConfiguration(
                clientId: '1:237115759240:android:57b787e3a03aca69fc9d3d',
              ),
            ],
          );
        } else {
          return const ManinScreenManager();
        }

        // Render your application if authenticated
      },
    );
  }
}
