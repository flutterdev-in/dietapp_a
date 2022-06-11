import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/hive%20Boxes/boxes.dart';
import 'package:dietapp_a/x_Browser/controllers/add_food_controller.dart';
import 'package:dietapp_a/x_Browser/controllers/browser_controllers.dart';
import 'package:dietapp_a/x_Browser/controllers/rxvariables_for_count_button.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

class TextFieldForBrowser extends StatelessWidget {
  const TextFieldForBrowser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bc.tec.text = "Youtube";
    bc.currentSearchEngineGYT.value =
        boxIndexes.get(bc.currentSearchEngine) ?? "G";
    return Container(
      height: 45,
      color: Colors.transparent,
      child: FocusScope(
        child: Focus(
          onFocusChange: (isFocused) {
            bc.isFocused.value = isFocused;
          },
          child: Obx(() => TextField(
                autocorrect: false,
                autofocus: false,
                controller: bc.tec,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  prefixIcon: bc.isFocused.value ? prefixIcon() : null,
                  suffixIcon: textfieldSuffix(),
                  prefixIconConstraints:
                      BoxConstraints.tight(const Size.square(50)),
                  hintText: 'Search or enter URL',
                  contentPadding: const EdgeInsets.fromLTRB(10, 0, 3, 0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                ),
                onChanged: (value) async {
                  value = value.trimLeft();
                  value = value.replaceAll(RegExp(r"\s{2,}"), " ");
                  if (!value.contains(RegExp(r"\s$")) && value.length > 3) {
                    EasyDebounce.debounce("1", const Duration(seconds: 2), () {
                      adfc.searchString.value = value;
                    });
                  }
                },
                onTap: () async {
                  bc.tec.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: bc.tec.text.length,
                  );
                  bc.tec.selection = TextSelection.fromPosition(
                      TextPosition(offset: bc.tec.text.length));
                },
                onSubmitted: (value) async {
                  String uriString = value;
                  if (value.trim().toLowerCase() == "google") {
                    uriString = "https://www.google.com/";
                  } else if (value.trim().toLowerCase() == "youtube") {
                    uriString = "https://m.youtube.com/";
                  } else if (!GetUtils.isURL(value)) {
                    if (bc.currentSearchEngineGYT.value == "Y") {
                      uriString =
                          "https://m.youtube.com/results?search_query=$value";
                    } else if (bc.currentSearchEngineGYT.value == "T") {
                      uriString =
                          "https://recipes.timesofindia.com/searchresults.cms?query=$value";
                    } else {
                      uriString = "https://www.google.com/search?q=$value";
                    }
                  }

                  if (bc.wvc != null) {
                    await bc.wvc!.loadUrl(
                        urlRequest: URLRequest(url: Uri.parse(uriString)));
                  }
                },
              )),
        ),
      ),
    );
  }

  Widget textfieldSuffix() {
    return Obx(
      () {
        if (bc.isBrowserForRefURL.value) {
          return const SizedBox();
        } else if (bc.isFocused.value) {
          return IconButton(
              splashRadius: 24.0,
              onPressed: () => bc.tec.clear(),
              icon: const Icon(MdiIcons.close, color: Colors.black));
        } else if (GetUtils.isURL(bc.currentURL.value)) {
          return IconButton(
            splashRadius: 24.0,
            onPressed: () async {
              Metadata? data = await MetadataFetch.extract(bc.currentURL.value);
              FoodModel fdcm = FoodModel(
                foodName: data?.title ?? "",
                foodAddedTime: DateTime.now(),
                foodTakenTime: null,
                isCamFood: null,
                isFolder: false,
                rumm: await rummfos.rummModel(bc.currentURL.value,
                    metaData: data),
                notes: null,
              );
              List<String> ls = adfc.addedFoodList.value
                  .map((element) => element.rumm?.url.toString() ?? "")
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
            icon: const Icon(MdiIcons.webPlus, color: Colors.black87),
          );
        } else {
          return const IconButton(
            splashRadius: 24.0,
            onPressed: null,
            icon: Icon(MdiIcons.webPlus, color: Colors.black45),
          );
        }
      },
    );
  }

  Widget prefixIcon() {
    
    return PopupMenuButton(
      child: Obx(() {
        if (bc.currentSearchEngineGYT.value == "Y") {
          return const Icon(MdiIcons.youtube, color: Colors.red, size: 30);
        } else if (bc.currentSearchEngineGYT.value == "T") {
          return const Icon(MdiIcons.alphaTBoxOutline,
              color: Colors.red, size: 30);
        } else {
          return const Icon(MdiIcons.google, size: 30);
        }
      }),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Row(
              children: const [
                Icon(MdiIcons.google, size: 30),
                // SvgPicture.asset(Assets().googleIcon),
                SizedBox(width: 5),
                Text("Google"),
              ],
            ),
            onTap: () {
              bc.currentSearchEngineGYT.value = "G";
              boxIndexes.put(bc.currentSearchEngine, "G");
            },
          ),
          PopupMenuItem(
            child: Row(
              children: const [
                Icon(MdiIcons.youtube, color: Colors.red, size: 30),
                SizedBox(width: 5),
                Text("Youtube"),
              ],
            ),
            onTap: () {
              bc.currentSearchEngineGYT.value = "Y";
              boxIndexes.put(bc.currentSearchEngine, "Y");
            },
          ),
          PopupMenuItem(
            child: Row(
              children: const [
                Icon(MdiIcons.alphaTBoxOutline, color: Colors.red, size: 30),
                SizedBox(width: 5),
                Text("TimesFood"),
              ],
            ),
            onTap: () {
              bc.currentSearchEngineGYT.value = "T";
              boxIndexes.put(bc.currentSearchEngine, "T");
            },
          ),
        ];
      },
    );
  }
}
