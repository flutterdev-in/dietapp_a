import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/add_food_sreen.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/browser_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RefURLWidget extends StatelessWidget {
  RefUrlMetadataModel refUrlMetadataModel;
  RefURLWidget({Key? key, required this.refUrlMetadataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (refUrlMetadataModel.url == "https://m.youtube.com/") {
      return Card(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("  Ref URL"),
          IconButton(
              onPressed: () {
                bc.isBrowserForRefURL.value = true;
                Get.to(AddFoodScreen());
              },
              icon: Icon(MdiIcons.webPlus)),
        ],
      ));
    } else {
      return GFListTile(
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        avatar: URLavatar(
            imgURL: refUrlMetadataModel.img ?? "",
            webURL: refUrlMetadataModel.url),
        title: Text(
          refUrlMetadataModel.title ?? refUrlMetadataModel.url,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        icon: IconButton(
            onPressed: () {
              bc.isBrowserForRefURL.value = true;
              Get.to(AddFoodScreen());
            },
            icon: Icon(MdiIcons.webSync)),
      );
    }
  }
}
