import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/helper%20widgets/youtube_chat_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleTimingMiddle extends StatelessWidget {
  final DefaultTimingModel dtm;
  final String? text;
  const SingleTimingMiddle({
    Key? key,
    required this.dtm,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonTopWidgetMiddle(child: Container());
  }

  Widget hasRefURL() {
    RefUrlMetadataModel rum = RefUrlMetadataModel.fromMap(dtm.refUrlMetadata!);
    return Column(children: [
      Row(
        children: [
          Icon(MdiIcons.clipboardTextClockOutline),
          Text(dtm.timingName)
        ],
      ),
      YoutubeChatViewWidget(webURL: rum.url, imgURL: rum.img, title: rum.title)
    ]);
  }
}
