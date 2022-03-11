import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/foods_collection_listview.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/bottom%20bars/bottom_bar_for_fc.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/bottom%20bars/paste_bar_for_fc.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/top_bar_foods_collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFoodsCollectionView extends StatelessWidget {
  const MyFoodsCollectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const FoodsCollectionTopBar(),
        const Expanded(child: FoodsCollectionListView()),
        Obx(
          () => SizedBox(
            height: 200,
            child: SingleChildScrollView(child: Text(fcc.printPurpose.value)),
          ),
        ),
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
    );
  }
}
