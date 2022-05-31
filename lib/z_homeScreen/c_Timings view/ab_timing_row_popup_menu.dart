import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/x_Browser/_browser_main_screen.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/y_Active%20diet/functions/delete_active_entries.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuItemsTimingViewHS extends StatelessWidget {
  final DocumentReference<Map<String, dynamic>> thisTimingDR;
  const MenuItemsTimingViewHS({Key? key, required this.thisTimingDR})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: const Icon(MdiIcons.dotsVertical),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  apc.currentActiveTimingDR.value = thisTimingDR;
                  Get.to(() => const AddFoodScreen());
                },
                child: const Text("Add Foods from Web"),
              ),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {},
                child: const Text("Add Foods from Collection"),
              ),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {},
                child: const Text("Add Foods from Plans"),
              ),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  await deleteActiveEntries.deleteActiveTiming(thisTimingDR);
                  Navigator.pop(context);
                },
                child: const Text("Delete this timing"),
              ),
            ),
          ];
        },
      ),
    );
  }
}
