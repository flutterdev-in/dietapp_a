import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

//
class WebViewPluginScreen extends StatefulWidget {
  const WebViewPluginScreen({Key? key}) : super(key: key);

  @override
  State<WebViewPluginScreen> createState() => _WebViewPluginScreenState();
}

class _WebViewPluginScreenState extends State<WebViewPluginScreen> {
  // FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SizedBox(
        // width: 200,
        child: WebView(
          // appBar: AppBar(),
          initialUrl: 'https://www.youtube.com',
        ),
      ),
      floatingActionButton:
          IconButton(onPressed: () {}, icon: const Icon(MdiIcons.plus)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
    // Stack(
    //   children: [3
    //     WebviewScaffold(
    //       appBar: AppBar(),
    //       url: 'https://www.youtube.com',
    //     ),
    //     Positioned(
    //       child: IconButton(onPressed: () {}, icon: Icon(MdiIcons.plus)),
    //       right: 10,
    //       bottom: 10,
    //     )
    //   ],
    // );
  }
}
