import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

BrowserController bc = BrowserController();

class BrowserController {
  InAppWebViewController? wvc;
  TextEditingController tec = TextEditingController();
  Rx<String> currentURL = "youtube.com".obs;
  Rx<bool> isTextFieldTapped = false.obs;
  Rx<String> homeURL = "https://google.com".obs;
  Rx<bool> isLinkYoutubeVideo = false.obs;
  Rx<bool> isValidURL = false.obs;

  void tecText(String text) {
    tec.text = text;
    tec.selection =
        TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
