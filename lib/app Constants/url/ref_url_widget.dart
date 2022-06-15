import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/x_Browser/_browser_main_screen.dart';
import 'package:dietapp_a/x_Browser/controllers/browser_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RefURLWidget extends StatelessWidget {
  final RefUrlMetadataModel refUrlMetadataModel;
  final bool editingIconRequired;

  const RefURLWidget({
    Key? key,
    required this.refUrlMetadataModel,
    this.editingIconRequired = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (refUrlMetadataModel.url == "https://m.youtube.com/") {
      return SizedBox(
        height: 46,
        child: Card(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("  Ref URL"),
            IconButton(
                onPressed: () {
                  bc.isBrowserForRefURL.value = true;
                  Get.to(const AddFoodScreen());
                },
                icon: const Icon(MdiIcons.webPlus)),
          ],
        )),
      );
    } else {
      return Column(
        children: [
          GFListTile(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            avatar: UrlAvatar(refUrlMetadataModel
                ),
            title: Text(
              refUrlMetadataModel.title ?? refUrlMetadataModel.url,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            icon: editingIconRequired
                ? IconButton(
                    onPressed: () {
                      bc.isBrowserForRefURL.value = true;
                      Get.to(const AddFoodScreen());
                    },
                    icon: const Icon(MdiIcons.webSync))
                : null,
          ),
          Divider(thickness: 2, color: Colors.deepPurple.shade100)
        ],
      );
    }
  }
}
