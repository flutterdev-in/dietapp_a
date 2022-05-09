import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/hive%20Boxes/boxes.dart';
import 'package:dietapp_a/x_Browser/c_fav_web_pages.dart';
import 'package:dietapp_a/x_Browser/controllers/browser_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

class MenuButtons extends StatelessWidget {
  const MenuButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: mdWidth(context) * 3 / 4,
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
                  color: Colors.black,
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
                color: Colors.black,
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
                color: Colors.black,
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
                  color: Colors.black,
                  size: 20,
                );
              }),
            ),
            onTap: () async {
              if (bc.lastFavWebURL.value != bc.currentURL.value) {
                bc.lastFavWebURL.value = bc.currentURL.value;
                Metadata? data =
                    await MetadataFetch.extract(bc.currentURL.value);
                FavWebPagesModel(
                    webURL: bc.currentURL.value,
                    title: data?.title ?? "",
                    imageURL: data?.image ?? "");
                Map dataMap = {
                  "webURL": bc.currentURL.value,
                  "title": data?.title ?? "",
                  "imageURL": data?.image ?? ""
                };

                boxFavWebPages.add(dataMap);
                rxFavWebPages.add(dataMap);
              }
            },
          ),
          InkWell(
            child: const SizedBox(
              width: 35,
              height: double.maxFinite,
              child: Icon(
                MdiIcons.youtube,
                color: Colors.red,
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
