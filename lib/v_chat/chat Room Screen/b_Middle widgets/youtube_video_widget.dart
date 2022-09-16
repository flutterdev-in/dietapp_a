import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/helper%20widgets/youtube_chat_view_widget.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:flutter/material.dart';

class YoutubeVideoWidget extends StatelessWidget {
  final FoodModel fdcm;

  final String? text;
  const YoutubeVideoWidget({Key? key, required this.fdcm, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonTopWidgetMiddle(
      text: text,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blueGrey.shade900,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
              child:
                  YoutubeChatViewWidget(rumm: fdcm.rumm!, title: fdcm.foodName),
            ),
          ),
        ],
      ),
    );
  }
}
