import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/constants/adf_const_variables.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/add_food_controller.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/browser_controllers.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/rxvariables_for_count_button.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/widgets/ab_count_button_adfd.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/widgets/a_textfield_adfd.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/widgets/browser/b_web_view_adfd.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/widgets/browser/bb_menu_items_adfd.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

class AddFoodScreen extends StatelessWidget {
  const AddFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (bc.currentURL.value != "https://m.youtube.com/") {
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
            Expanded(child: InAppWebViewWidget()),
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
          SizedBox(width: 5),
          Expanded(child: TextFieldAdfd(), flex: 5),
          SizedBox(width: 10),
          Obx(() => bc.isBrowserForRefURL.value ? forRefURL() : countButton()),
          SizedBox(
            width: 40,
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
                title: data.title);
            if (pcc.isCombinedCreationScreen.value) {
              await pcc.currentTimingDR.value.update({
                dtmos.refUrlMetadata: bc.currentRefUrlMetadataModel.value
                    .toMap()
              });
            } else {
              bc.currentRefURLimageURL.value = data.image ?? "";
            }
          }
          Get.back();
        },
        icon: Icon(MdiIcons.webPlus, color: Colors.black));
  }

  Widget countButton() {
    return Obx(() {
      if (bc.functionButtonType.value == "getURL") {
        return IconButton(onPressed: null, icon: Icon(MdiIcons.plus));
      } else if (countbvs.isItemAdded.value) {
        return SizedBox(
          width: 44,
          height: 40,
          child: Lottie.asset(adfcv.heartAnimation, repeat: false),
        );
      } else if (countbvs.isItemDuplicate.value) {
        return SizedBox(
          width: 44,
          height: 40,
          child: Lottie.network(
              'https://assets8.lottiefiles.com/packages/lf20_olhixnxg.json',
              repeat: false),
        );
      } else if (countbvs.isAddAll.value) {
        return SizedBox(
          width: 44,
          height: 40,
          child: Lottie.asset(adfcv.sendAnimation, repeat: false),
        );
      } else if (countbvs.isClearAll.value) {
        return SizedBox(
          width: 44,
          height: 40,
          child: Lottie.asset(adfcv.deleteAnimation, repeat: false),
        );
      } else {
        return CountButtonAdfdW();
      }
    });
  }

  Widget textFieldPrefix() {
    return PopupMenuButton(
      child: Icon(
        MdiIcons.menu,
        color: Colors.white,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(child: Text("DietApp")),
          PopupMenuItem(child: Text("Youtube")),
          PopupMenuItem(child: Text("TimesFood")),
          PopupMenuItem(child: Text("Google")),
        ];
      },
    );
  }
}
