import 'package:dietapp_a/dartUtilities/lowercase_text_formatter.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/add_food_controller.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TextFieldAdfd extends StatelessWidget {
  const TextFieldAdfd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late WebViewController webController;
    Rx<bool> isTextFieldActive = true.obs;
    Rx<String> currentURL = "".obs;
    return Container(
      height: 45,
      color: Colors.transparent,
      child: TextField(
        autocorrect: false,
        autofocus: true,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.search,
        inputFormatters: [LowerCaseTextFormatter()],
        decoration: InputDecoration(
          // prefixIcon: textFieldPrefix(),
          hintText: 'Search food',
          contentPadding: const EdgeInsets.all(15),
          enabledBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(24.0),
            borderSide: BorderSide(color: Colors.pinkAccent),
          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(24.0),
            borderSide: BorderSide(color: Colors.black38),
          ),
        ),
        onChanged: (value) {
          value = value.trimLeft();
          value = value.replaceAll(RegExp(r"\s{2,}"), " ");
          if (!value.contains(RegExp(r"\s$")) && value.length > 3) {
            EasyDebounce.debounce("1", Duration(seconds: 2), () {
              adfc.searchString.value = value;
            });
          }
        },
        // onEditingComplete: () {
        //   print("object");
        //   // isTextFieldActive.value = false;
        // },
        onSubmitted: (value) {
          print("object");
          // String youtubeUrl =
          //     "https://www.vegrecipesofindia.com/#search/q=";
          // // "https://www.youtube.com/results?search_query=";
          // if (value.isEmpty) {
          //   youtubeUrl = "https://www.vegrecipesofindia.com";
          //   // "https://www.youtube.com/";
          // }

          // webController.loadUrl(youtubeUrl + value);
          // isTextFieldActive.value = false;
        },
        onTap: () {
          isTextFieldActive.value = true;
        },
      ),
    );
  }
}
