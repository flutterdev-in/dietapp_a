import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/rx_variables.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/foods_collection_listview.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/top_bar_foods_collection.dart';
import 'package:flutter/material.dart';

class MyFoodsCollectionView extends StatelessWidget {
  const MyFoodsCollectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FoodsCollectionTopBar(),
        Expanded(child: FoodsCollectionListView()),
      ],
    );
  }
}
