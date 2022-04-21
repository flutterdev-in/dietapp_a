import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/add_food_controller.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/browser_controllers.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/rxvariables_for_count_button.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

class InAppWebViewWidget extends StatelessWidget {
  const InAppWebViewWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(bc.homeURL.value)),
      onWebViewCreated: (controller) {
        bc.wvc = controller;
      },
      onTitleChanged: (controller, title) async {
        bc.isTextFieldTapped.value = false;
        Uri? u = await bc.wvc?.getUrl();
        if (u != null) bc.currentURL.value = u.toString();
        if (title != null) {
          bc.tec.text = title.replaceAll("- Google Search", "").trim();
        }
      },
      onLongPressHitTestResult: (controller, hitTestResult) async {
        if (bc.functionButtonType.value != "getURL") {
          RequestFocusNodeHrefResult? k = await bc.wvc!.requestFocusNodeHref();
          Uri uri = k?.url ?? Uri.parse("about:blank");
          String longPressURL = uri.toString();
          String title = k?.title ?? "";

          if (!title.contains(RegExp(r"[a-zA-Z]+"))) {
            var data = await MetadataFetch.extract(longPressURL);
            title = data?.title ?? "";
          }
          RefUrlMetadataModel? rumm0 = await rummfos.rummModel(longPressURL);

          FoodsCollectionModel fdcm = FoodsCollectionModel(
            fieldName: title,
            fieldTime: Timestamp.fromDate(DateTime.now()),
            isFolder: false,
            notes: null,
            rumm: rumm0,
          );

          List<String> ls = adfc.addedFoodList.value
              .map((element) => element.rumm?.url.toString() ?? "")
              .toList();

          if (!ls.contains(longPressURL)) {
            countbvs.isItemAdded.value = true;
            adfc.addedFoodList.value.add(fdcm);
            await Future.delayed(const Duration(milliseconds: 1500));
            countbvs.isItemAdded.value = false;
          } else {
            countbvs.isItemDuplicate.value = true;
            await Future.delayed(const Duration(milliseconds: 4000));
            countbvs.isItemDuplicate.value = false;
          }
        }
      },
    );
  }
}
