import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebTestScreen extends StatelessWidget {
   WebTestScreen({Key? key}) : super(key: key);
 late WebViewController wc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: null, icon: Icon(MdiIcons.plus))],
      ),
      body: WebView(
        onWebViewCreated: (controller) {
          wc = controller;
          
        },
      ),
    );
  }
}
