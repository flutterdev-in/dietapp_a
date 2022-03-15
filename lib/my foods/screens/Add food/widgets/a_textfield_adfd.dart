import 'package:dietapp_a/dartUtilities/lowercase_text_formatter.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/add_food_controller.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/browser_controllers.dart';
import 'package:dietapp_a/x_customWidgets/colors.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TextFieldAdfd extends StatelessWidget {
  TextFieldAdfd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<bool> isTextFieldTap = false.obs;
    late WebViewController webController;
    Rx<bool> isTextFieldActive = true.obs;
    Rx<String> currentURL = "".obs;

    bc.tec.text = "Youtube";
    return Container(
      height: 45,
      color: Colors.transparent,
      child: TextField(
        autocorrect: false,
        autofocus: false,
        controller: bc.tec,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.search,
        
        decoration: InputDecoration(
          suffixIcon: textfieldSuffix(),
          hintText: 'Search or enter URL',
          contentPadding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
          enabledBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(24.0),
            borderSide: BorderSide(color: Colors.black12),
          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(24.0),
            borderSide: BorderSide(color: Colors.black12),
          ),
        ),
        onChanged: (value) async {
          value = value.trimLeft();
          value = value.replaceAll(RegExp(r"\s{2,}"), " ");
          if (!value.contains(RegExp(r"\s$")) && value.length > 3) {
            EasyDebounce.debounce("1", Duration(seconds: 2), () {
              adfc.searchString.value = value;
            });
          }

         
        },
        onTap: () async {
          bc.isTextFieldTapped.value = true;
         bc. tec.selection =
        TextSelection.fromPosition(TextPosition(offset: bc.tec.text.length));
        },
        onSubmitted: (value) async {
          bc.isTextFieldTapped.value = false;
         bool isURL =  GetUtils.isURL(value);
         Uri? uri;
          if (isURL) {
            uri = Uri.parse(value);
          }else{
            uri = Uri.parse(
                "https://www.google.com/search?q=$value");
          }
          
          if (bc.wvc != null) {
            await bc.wvc!.loadUrl(urlRequest: URLRequest(url: uri));
          }
        },
      ),
    );
  }

  Widget textfieldSuffix() {
    return Obx(
      () {
        if (bc.isTextFieldTapped.value) {
          return IconButton(
              onPressed: () => bc.tec.clear(), icon: Icon(MdiIcons.close));
        } else if (bc.isLinkYoutubeVideo.value) {
          return IconButton(
            onPressed: null,
            icon: Stack(
              children: [
                Icon(MdiIcons.youtube),
                Icon(MdiIcons.plus),
              ],
            ),
          );
        } else if (bc.isValidURL.value) {
          return IconButton(
            onPressed: () async {
              if (bc.wvc != null) {
                bc.tec.text = await bc.wvc!.getTitle() ?? "";
              }
            },
            padding: const EdgeInsets.all(0),
            icon: Icon(MdiIcons.webPlus, color: primaryColor),
          );
        } else {
          return IconButton(
            onPressed: () {},
            icon: const Icon(MdiIcons.webPlus, color: Colors.black45),
          );
        }
      },
    );
  }
}
