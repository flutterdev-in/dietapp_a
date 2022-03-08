import 'package:dietapp_a/my%20foods/screens/a_food%20timings/food_timings_tile.dart';
import 'package:flutter/material.dart';

class MyFoodsView extends StatelessWidget {
  const MyFoodsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      FoodTimingsTile(),
    ]);
  }
}
