import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/add_food_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFoodBottomBar extends StatelessWidget {
  const AddFoodBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text("Done"),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text("Clear"),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Obx(
              () => Text(adfc.grossSelectedFCmodelMap.value.length.toString())),
        ),
      ],
    );
  }
}
