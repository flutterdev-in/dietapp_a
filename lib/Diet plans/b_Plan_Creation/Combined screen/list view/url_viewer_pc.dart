import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class URLviewerPC extends StatelessWidget {
  final RefUrlMetadataModel? rumm;
  const URLviewerPC({Key? key, required this.rumm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: WebView(
        initialUrl: rumm?.url,
        javascriptMode: JavascriptMode.unrestricted,
      )),
    );
  }
}
