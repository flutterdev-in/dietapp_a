import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/foods_collection_listview.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/bottom%20bars/bottom_bar_for_fc.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/bottom%20bars/paste_bar_for_fc.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/top_bar_foods_collection.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodCollectionScreen extends StatefulWidget {
  const FoodCollectionScreen({Key? key}) : super(key: key);

  @override
  State<FoodCollectionScreen> createState() => _FoodCollectionScreenState();
}

class _FoodCollectionScreenState extends State<FoodCollectionScreen> {
  @override
  void initState() {
    fcc.currentCR.value = userDR.collection(fmos.foodsCollection);
    fcc.listFoodModelsForPath.value.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text("Foods Collection"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const FoodsCollectionTopBar(),
          const Expanded(child: FoodsCollectionListView()),
          Obx(() {
            if (fcc.isCopyOrMoveStarted.value) {
              return const PasteBarForFC();
            } else if (fcc.isSelectionStarted.value ||
                fcc.listSelectedItemsDRsForOperation.value.isNotEmpty) {
              return const OnSelectedBottomBarForFoodCollection();
            } else {
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }
}
