import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPageMiddle extends StatelessWidget {
  final String webURL;
  final String? title;
  const WebPageMiddle({Key? key, required this.webURL, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title ?? ""),
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: webURL,
        ),
      ),
    );
  }
}
