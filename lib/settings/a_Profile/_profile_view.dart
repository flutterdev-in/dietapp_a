import 'package:dietapp_a/settings/a_Profile/b_basic_info.dart';
import 'package:dietapp_a/settings/a_Profile/a_profile_first.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
          ),
          body: ListView(
            shrinkWrap: true,
            children: [
              const ProfileFirst(),
              const SizedBox(height: 10),
              basic(),
              medical(),
              targets(),
              food(),
            ],
          )),
    );
  }

  Widget basic() {
    return GFListTile(
      avatar: const Icon(
        Icons.manage_accounts,
      ),
      titleText: "Basic Information",
      subTitleText: "Gender,Age,Height,Weight,Activity",
      onTap: () {
        Get.to(() => BasicInfo());
      },
    );
  }

  Widget medical() {
    return GFListTile(
      avatar: const Icon(
        FontAwesomeIcons.userMd,
      ),
      titleText: "Mediacal Condition",
      // subTitleText: "Gender,Age,Height,Weight,Activity",
      onTap: () {
        Get.to(() => BasicInfo());
      },
    );
  }

  Widget targets() {
    return GFListTile(
      avatar: Icon(
        Icons.flag,
      ),
      titleText: "Targets",
      // subTitleText: "",
    );
  }

  Widget food() {
    return GFListTile(
      avatar: Icon(
        MdiIcons.foodVariant,
      ),
      titleText: "Food Preferences",
      // subTitleText: "",
    );
  }

  Widget rda() {
    return GFListTile(
      avatar: Icon(
        MdiIcons.foodVariant,
      ),
      titleText: "RDA",
      // subTitleText: "",
    );
  }
}