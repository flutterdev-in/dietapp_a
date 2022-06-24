import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  final String webURL;
  final String? title;
  const WebViewPage(this.webURL, this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<int> progress = 0.obs;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => GFProgressBar(
                  percentage: progress.value > 100
                      ? 1.0
                      : progress.value.toDouble() / 100,
                  lineHeight: progress.value < 100 ? 5.0 : 0.0,
                  progressBarColor: primaryColor,
                )),
            Expanded(
              child: Flexible(
                  child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: webURL,
                onProgress: (value) {
                  progress.value = value;
                },
              )),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.small(
            child: const Icon(MdiIcons.arrowLeft),
            backgroundColor: secondaryColor,
            onPressed: () {
              Get.back();
            }),
      ),
    );
  }
}
