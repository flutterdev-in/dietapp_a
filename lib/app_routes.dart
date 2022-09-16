import 'package:dietapp_a/auth_gate.dart';
import 'package:get/get.dart';

class AppRoutes {
  //static const initial = GetPage(name: "/", page: ()=>HomeScreen2())
  static final routes = [
    GetPage(
      name: "/",
      page: () => const AuthGate(),
      //binding: HomeBinding(),
    ),
    // // Login
    // GetPage(
    //     name: "/loginScreen", page: () => LoginView(), binding: LoginBinding()),
    // Welcome
  ];
}
