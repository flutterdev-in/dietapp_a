import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/y_Active%20diet/chat/month_calander.dart';
import 'package:dietapp_a/z_homeScreen/timing_view_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: const [
            MonthCalander(),
            TimingViewHomeScreen(),
          ],
        ),
        Obx(() => isLoading.value
            ? const SpinKitRotatingCircle(
                color: Colors.white,
                size: 50.0,
              )
            : const SizedBox()),
      ],
    );
  }
}
