
import 'package:dietapp_a/app_routes.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      // initialBinding: HomeBinding(),
      theme: ThemeData(
        primaryColor: Colors.pink,
        // textTheme: Theme.of(context).textTheme.apply(
        //       fontSizeFactor: 1.0,
        //     ),
      ),
      title: 'DietApp',
      initialRoute: "/",
      getPages: AppRoutes.routes,
      //home: AnimatedContainerFlex(),
    );
  }
}
