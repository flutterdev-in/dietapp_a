import 'package:dietapp_a/hive%20Boxes/boxes.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/browser_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

class MenuButtons extends StatelessWidget {
  const MenuButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: const SizedBox(
              width: 35,
              height: double.maxFinite,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  MdiIcons.arrowBottomLeftBoldBoxOutline,
                ),
              ),
            ),
            onTap: () {
              Get.back();
              Get.back();
            },
          ),
          InkWell(
            child: const SizedBox(
              width: 35,
              height: double.maxFinite,
              child: Icon(
                MdiIcons.arrowRight,
              ),
            ),
            onTap: () {
              bc.wvc?.goForward();
              Get.back();
            },
          ),
          InkWell(
            child: const SizedBox(
              width: 35,
              height: double.maxFinite,
              child: Icon(
                MdiIcons.refresh,
              ),
            ),
            onTap: () {
              bc.wvc?.reload();
              Get.back();
            },
          ),
          InkWell(
            child: SizedBox(
              width: 35,
              height: double.maxFinite,
              child: Obx(() {
                bool isSameURL = false;
                if (bc.lastFavWebURL.value == bc.currentURL.value) {
                  isSameURL = true;
                }
                return Icon(
                  isSameURL ? MdiIcons.heart : MdiIcons.cardsHeartOutline,
                  size: 20,
                );
              }),
            ),
            onTap: () async {
              if (bc.lastFavWebURL.value != bc.currentURL.value) {
                bc.lastFavWebURL.value = bc.currentURL.value;
                Metadata? data =
                    await MetadataFetch.extract(bc.currentURL.value);
                Map dataMap = {
                  "webURL": bc.currentURL.value,
                  "title": data?.title ?? "",
                  "imageURL": data?.image ?? ""
                };
                boxFavWebPages.add(dataMap);
              }
            },
          ),
          InkWell(
            child: const SizedBox(
              width: 35,
              height: double.maxFinite,
              child: Icon(
                MdiIcons.home,
              ),
            ),
            onTap: () {
              bc.wvc?.loadUrl(
                urlRequest: URLRequest(
                  url: Uri.parse(bc.homeURL.value),
                ),
              );
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
