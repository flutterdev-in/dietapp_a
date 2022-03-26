import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

BrowserController bc = BrowserController();

class BrowserController {
  InAppWebViewController? wvc;
  TextEditingController tec = TextEditingController();
  Rx<String> currentURL = "https://m.youtube.com/".obs;
  Rx<String> currentRefURLimageURL = "".obs;
  final currentRefUrlMetadataModel =
      RefUrlMetadataModel(url: "https://m.youtube.com/", img: null, title: null)
          .obs;
  Rx<bool> isTextFieldTapped = false.obs;
  Rx<String> homeURL = "https://m.youtube.com/".obs;
  Rx<String> lastFavWebURL = "".obs;
  Rx<String> functionButtonType = "".obs;
  Rx<bool> isBrowserForRefURL = false.obs;
  void tecText(String text) {
    tec.text = text;
    tec.selection =
        TextSelection.fromPosition(TextPosition(offset: text.length));
  }

  Future<void> loadURl(String webURL) async {
    if (bc.wvc != null) {
      await bc.wvc!.loadUrl(urlRequest: URLRequest(url: Uri.parse(webURL)));
    }
  }
}
