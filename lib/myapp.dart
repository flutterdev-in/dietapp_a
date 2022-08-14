import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,

      navigatorKey: Get.key,
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
      // initialRoute: "/",.
      // getPages: AppRoutes.routes,
      home:
          // const MyHomePage0(),
          const AuthGate(),
    );
  }
}

class MyHomePage0 extends StatelessWidget {
  const MyHomePage0({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 500,
          height: 500,
          color: primaryColor,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  width: 340,
                  height: 340,
                  decoration: BoxDecoration(
                    border:
                        //Border.all(color: Colors.pink.shade900, width: 15),
                        Border.all(color: Colors.white, width: 15),
                    borderRadius: BorderRadius.circular(68),
                  ),
                  child: Center(
                    child: Stack(
                      children: const [
                        Icon(MdiIcons.chatPlusOutline,
                            color: Colors.white, size: 315),
                        Center(
                            child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 15),
                          child: Text("DietApp",
                              textScaleFactor: 3.6,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900)),
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
