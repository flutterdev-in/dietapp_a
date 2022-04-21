import 'package:dietapp_a/Diet%20plans/a_Main%20Screen/b_list_diet_plans.dart';
import 'package:flutter/material.dart';

class MainScreenDP extends StatelessWidget {
  const MainScreenDP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            SizedBox(),
          ],
        ),
        Expanded(
            flex: 1,
            child: Card(
                child: Column(
              children: const [
                Text("Active plans"),
                ListDietPlansW(),
              ],
            ))),
        Expanded(
            flex: 1,
            child: Card(
                child: Column(
              children: const [
                Text("Diet plans"),
                ListDietPlansW(),
              ],
            ))),
      ],
    );
  }
}
