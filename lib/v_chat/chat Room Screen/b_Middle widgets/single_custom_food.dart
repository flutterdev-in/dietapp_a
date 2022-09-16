import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleCustomFoodMiddle extends StatelessWidget {
  final FoodModel fdcm;

  final String? text;
  const SingleCustomFoodMiddle({Key? key, required this.fdcm, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonTopWidgetMiddle(
      text: text,
      child: Container(
        color: chatFoodCollectionColor,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            child: Row(
              children: [
                const Icon(MdiIcons.pencilBox, color: Colors.white, size: 35),
                const SizedBox(width: 15),
                Column(
                  children: [
                    Text(fdcm.foodName,
                        style: const TextStyle(color: Colors.white)),
                    if (fdcm.notes != null && fdcm.notes!.isNotEmpty)
                      // expText(fdcm.notes!)!
                      Container(
                        constraints: const BoxConstraints(
                            maxHeight: 100, maxWidth: double.maxFinite),
                        child: ExpandableText(
                          fdcm.notes!,
                          expandOnTextTap: true,
                          collapseOnTextTap: true,
                          maxLines: 4,
                          animation: true,
                          animationDuration: const Duration(milliseconds: 700),
                          expandText: "more",
                          collapseText: "show less",
                          style: const TextStyle(
                            color: Colors.yellow,
                            fontSize: 13,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
