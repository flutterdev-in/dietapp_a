import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/browser_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

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
        bc.isValidURL.value = true;
        bc.tec.text = title.toString();
      },
      onLongPressHitTestResult: (controller, hitTestResult) async {},
    );
  }
}
