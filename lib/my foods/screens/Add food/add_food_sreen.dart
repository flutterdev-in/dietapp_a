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

class AddFoodScreen extends StatelessWidget {
  const AddFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bc.wvc?.goBack();
        return false;
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
          countButton(),
          SizedBox(
            width: 40,
            child: MenuItemsWebBrowser(),
          ),
        ],
      ),
    );
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
