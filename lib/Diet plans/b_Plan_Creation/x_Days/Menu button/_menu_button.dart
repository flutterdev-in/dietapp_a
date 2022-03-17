import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/widgets/browser/bba_menu_buttons.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/widgets/browser/c_fav_web_pages.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuButtonPCdays extends StatelessWidget {
  const MenuButtonPCdays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton(
        padding: const EdgeInsets.all(10.0),
        color: Colors.black87,
        child: Icon(MdiIcons.dotsVertical, color: Colors.white),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: deleteLast(),
            ),
            PopupMenuItem(
              child: FavWebPages(),
            ),
          ];
        },
      ),
    );
  }

  Widget deleteLast() {
    return InkWell(
      child: SizedBox(
        height: 45,
        child: Row(
          children: [
            Icon(MdiIcons.deleteRestore),
            SizedBox(width: 15),
            Text(
              "Delete last day",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      onTap: () async {
        await FirebaseFirestore.instance
            .doc(pcc.currentPlanDocRefPath.value)
            .collection(daypbims.days)
            .orderBy(daypbims.docEntryTime, descending: true)
            .limit(1)
            .get()
            .then((value) async {
          if (value.docs.length ==1) {
            DocumentReference docRef = value.docs.last.reference;
            await docRef.delete();
          }
        });
      },
    );
  }
}
