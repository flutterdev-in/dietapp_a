import 'package:dietapp_a/Diet%20plans/a_Main%20Screen/Appbar%20actions/diet_plan_screen_menu_button.dart';
import 'package:dietapp_a/Diet%20plans/a_Main%20Screen/b_list_diet_plans.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/w_Plan%20creation%20Screen/plan_creation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Diet Plans"), actions: const [
        MenuButtonDietPlanScreen(),
      ]),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              SizedBox(),
            ],
          ),
          const SizedBox(
            child: ListDietPlansW(),
            height: 200,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => PlanCreationScreen());
          },
          child: const Text("Create")),
    );
  }
}
