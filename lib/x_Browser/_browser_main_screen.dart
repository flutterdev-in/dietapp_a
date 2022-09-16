import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/x_Browser/a_textfield_adfd.dart';
import 'package:dietapp_a/x_Browser/ab_count_button_adfd.dart';
import 'package:dietapp_a/x_Browser/b_web_view_adfd.dart';
import 'package:dietapp_a/x_Browser/bb_menu_items_adfd.dart';
import 'package:dietapp_a/x_Browser/controllers/browser_controllers.dart';
import 'package:dietapp_a/x_Browser/controllers/rxvariables_for_count_button.dart';
import 'package:dietapp_a/x_customWidgets/lootie_animations.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

class AddFoodScreen extends StatelessWidget {
  const AddFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (bc.currentURL.value != "https://m.youtube.com/") {
          FocusScope.of(context).unfocus();
          bc.wvc?.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: appBarW(context),
        body: Column(
          children: [
            Obx(() => bc.loadingProgress.value == 0
                ? const SizedBox()
                : GFProgressBar(
                    percentage: bc.loadingProgress.value > 100
                        ? 1.0
                        : bc.loadingProgress.value.toDouble() / 100,
                    lineHeight: bc.loadingProgress.value < 100 ? 2.5 : 0.0,
                    progressBarColor: primaryColor,
                  )),
            const Expanded(child: InAppWebViewWidget()),
          ],
        ),
      ),
    );
  }

  appBarW(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 5,
      title: Row(
        children: [
          const SizedBox(width: 5),
          const Expanded(child: TextFieldForBrowser(), flex: 5),
          const SizedBox(width: 10),
          Obx(() => bc.isFocused.value
              ? const SizedBox()
              : bc.isBrowserForRefURL.value
                  ? forRefURL()
                  : countButton()),
          const Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: MenuItemsWebBrowser(),
          ),
        ],
      ),
    );
  }

  Widget forRefURL() {
    return IconButton(
        onPressed: () async {
          Metadata? data = await MetadataFetch.extract(bc.currentURL.value);
          if (data != null) {
            bc.currentRefUrlMetadataModel.value = RefUrlMetadataModel(
              url: data.url ?? bc.currentURL.value,
              img: data.image,
              title: data.title,
              isYoutubeVideo: rummfos.isYtVideo(data.url),
              youtubeVideoLength: await rummfos.ytVideoLength(data.url),
            );
            if (pcc.isCombinedCreationScreen.value) {
              if (pcc.currentDayDR.value.parent.id == admos.activeDaysPlan) {
                await pcc.currentTimingDR.value.update({
                  "$unIndexed.${rummfos.rumm}":
                      bc.currentRefUrlMetadataModel.value.toMap()
                });
              } else {
                await pcc.currentTimingDR.value.update({
                  "$unIndexed.${rummfos.rumm}":
                      bc.currentRefUrlMetadataModel.value.toMap()
                });
              }
            } else {
              bc.currentRefURLimageURL.value = data.image ?? "";
            }
          }
          Get.back();
        },
        icon: const Icon(MdiIcons.webPlus, color: Colors.black));
  }

  Widget countButton() {
    return Obx(() {
      if (bc.functionButtonType.value == "getURL") {
        return const IconButton(onPressed: null, icon: Icon(MdiIcons.plus));
      } else if (countbvs.isItemAdded.value) {
        return SizedBox(
          width: 44,
          height: 40,
          child: loot.plus(),
        );
      } else if (countbvs.isItemDuplicate.value) {
        return SizedBox(
          width: 44,
          height: 40,
          child: loot.duplicate(),
        );
      } else if (countbvs.isAddAll.value) {
        return SizedBox(
          width: 44,
          height: 40,
          child: loot.send(),
        );
      } else if (countbvs.isClearAll.value) {
        return SizedBox(
          width: 44,
          height: 40,
          child: loot.delete(),
        );
      } else {
        return CountButtonAdfdW();
      }
    });
  }

  Widget textFieldPrefix() {
    return PopupMenuButton(
      child: const Icon(
        MdiIcons.menu,
        color: Colors.white,
      ),
      itemBuilder: (context) {
        return [
          const PopupMenuItem(child: Text("DietApp")),
          const PopupMenuItem(child: Text("Youtube")),
          const PopupMenuItem(child: Text("TimesFood")),
          const PopupMenuItem(child: Text("Google")),
        ];
      },
    );
  }
}
