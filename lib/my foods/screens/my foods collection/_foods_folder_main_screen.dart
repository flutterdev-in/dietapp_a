import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/foods_folder_bottom_bar.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/foods_collection_listview.dart';
import 'package:flutter/material.dart';

class MyFoodsCollectionView extends StatelessWidget {
  const MyFoodsCollectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FoodsFolderTopBar(),
        Divider(thickness: 2),
        Expanded(child: FoodsCollectionListView()),
      ],
    );
  }
}
