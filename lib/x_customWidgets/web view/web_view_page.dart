import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  final String webURL;
  final String? title;
  const WebViewPage( this.webURL,  this.title,{Key? key })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: webURL,
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
