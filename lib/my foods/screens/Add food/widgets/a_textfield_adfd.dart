import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/add_food_controller.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/browser_controllers.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/rxvariables_for_count_button.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
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
          bc.tec.selection = TextSelection.fromPosition(
              TextPosition(offset: bc.tec.text.length));
        },
        onSubmitted: (value) async {
          bc.isTextFieldTapped.value = false;
          String uriString = value;
          if (value.trim().toLowerCase() == "google") {
            uriString = "https://www.google.com/";
          } else if (value.trim().toLowerCase() == "youtube") {
            uriString = "https://m.youtube.com/";
          } else if (!GetUtils.isURL(value)) {
            uriString = "https://www.google.com/search?q=$value";
          }

          if (bc.wvc != null) {
            await bc.wvc!
                .loadUrl(urlRequest: URLRequest(url: Uri.parse(uriString)));
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
        } else if (GetUtils.isURL(bc.currentURL.value)) {
          return IconButton(
            onPressed: () async {
              Metadata? data = await MetadataFetch.extract(bc.currentURL.value);
              FoodsCollectionModel fdcm = FoodsCollectionModel(
                fieldName: data?.title ?? "",
                fieldTime: Timestamp.fromDate(DateTime.now()),
                isFolder: false,
                imgURL: data?.image,
                webURL: data?.url,
              );
              List<String> ls = adfc.addedFoodList.value
                  .map((element) => element.webURL.toString())
                  .toList();

              if (!ls.contains(data?.url)) {
                countbvs.isItemAdded.value = true;
                adfc.addedFoodList.value.add(fdcm);
                await Future.delayed(const Duration(milliseconds: 1500));
                countbvs.isItemAdded.value = false;
              } else {
                countbvs.isItemDuplicate.value = true;
                await Future.delayed(const Duration(milliseconds: 3000));
                countbvs.isItemDuplicate.value = false;
              }
            },
            padding: const EdgeInsets.all(0),
            icon: Icon(MdiIcons.webPlus, color: Colors.black87),
          );
        } else {
          return IconButton(
            onPressed: null,
            icon: const Icon(MdiIcons.webPlus, color: Colors.black45),
          );
        }
      },
    );
  }
}
