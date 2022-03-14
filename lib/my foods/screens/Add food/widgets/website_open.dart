import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/add_food_controller.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FoodWebView extends StatelessWidget {
  const FoodWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            adfc.webFoodName.value,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: WebView(
          initialUrl: adfc.webURL.value,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
