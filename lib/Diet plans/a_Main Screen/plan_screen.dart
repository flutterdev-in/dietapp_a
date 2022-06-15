import 'package:dietapp_a/Diet%20plans/a_Main%20Screen/b_list_diet_plans.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/w_Plan%20creation%20Screen/plan_creation_screen.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diet Plans"),
      ),
      body: const ListDietPlansW(),
      floatingActionButton: FloatingActionButton(
          heroTag: null,
          backgroundColor: secondaryColor,
          onPressed: () async {
            await dtmos.getDefaultTimings().then((ltd) {
              Get.to(() => PlanCreationScreen(ltd));
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text("Create", textScaleFactor: 0.9),
              Text("Plan", textScaleFactor: 0.9),
            ],
          )),
    );
  }
}
