import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/add_food_controller.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/browser_controllers.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

class InAppWebViewWidget extends StatelessWidget {
  InAppWebViewWidget({Key? key}) : super(key: key);
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
        RequestFocusNodeHrefResult? k = await bc.wvc!.requestFocusNodeHref();
        Uri uri = k?.url ?? Uri.parse("about:blank");
        String longPressURL = uri.toString();
        String title = k?.title ?? "";

        if (!title.contains(RegExp(r"[a-zA-Z]+"))) {
          var data = await MetadataFetch.extract(longPressURL);
          title = data?.title ?? "";
        }
        FoodsCollectionModel fdcm = FoodsCollectionModel(
          fieldName: title,
          fieldTime: Timestamp.fromDate(DateTime.now()),
          isFolder: false,
          imgURL: k?.src,
          webURL: longPressURL,
        );

        List<String> ls = adfc.addedFoodList.value
            .map((element) => element.webURL.toString())
            .toList();

        if (!ls.contains(longPressURL)) {
          adfc.isItemAddedToList.value = true;
          adfc.addedFoodList.value.add(fdcm);
          await Future.delayed(const Duration(milliseconds: 1200));
          adfc.isItemAddedToList.value = false;
        }
      },
    );
  }
}
