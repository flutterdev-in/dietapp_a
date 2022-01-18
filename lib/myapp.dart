
import 'package:dietapp_a/app_routes.dart';
import 'package:dietapp_a/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData.from(
          colorScheme: ColorScheme.light(primary: Colors.deepPurple.shade800)),
      // initialBinding: HomeBinding(),
      // theme: ThemeData(
      //   primaryColor: Colors.green,

      //   // textTheme: Theme.of(context).textTheme.apply(
      //   //       fontSizeFactor: 1.0,
      //   //     ),
      // ),
      title: 'DietApp',
      // initialRoute: "/",
      // getPages: AppRoutes.routes,
      home: const AuthGate(),
    );
  }
}
