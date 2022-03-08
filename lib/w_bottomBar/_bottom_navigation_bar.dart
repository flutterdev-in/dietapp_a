import 'package:dietapp_a/w_bottomBar/rx_index_for_bottombar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavigationBarW extends StatelessWidget {
  const BottomNavigationBarW({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SalomonBottomBar(
        currentIndex: bottomBarindex.value,
        onTap: (i) {
          return bottomBarindex.value = i;
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text(""),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: FaIcon(FontAwesomeIcons.commentDots),
            title: Text(""),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text(""),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(MdiIcons.food),
            title: Text(""),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
