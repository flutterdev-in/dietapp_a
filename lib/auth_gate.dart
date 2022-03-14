import 'package:dietapp_a/my%20foods/screens/Add%20food/add_food_sreen.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/web_view_plugin.dart';
import 'package:dietapp_a/z_homeScreen/a_home_screen.dart';
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
                clientId: '1:237115759240:android:2ce36ff5e9acc35bfc9d3d',
              ),
            ],
          );
        } else {
          // return WebViewPluginScreen();
          return AddFoodScreen();
          return HomeScreen();
        }

        // Render your application if authenticated
      },
    );
  }
}
