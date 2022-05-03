import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: primaryColor),
        primaryColor: Colors.deepPurple.shade800,
        primaryColorLight: Colors.deepPurple.shade800,
        // textTheme: Theme.of(context).textTheme.apply(),
        popupMenuTheme: PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // initialBinding: HomeBinding(),
      title: 'DietApp',
      // initialRoute: "/",
      // getPages: AppRoutes.routes,
      home: const AuthGate(),
    );
  }
}
