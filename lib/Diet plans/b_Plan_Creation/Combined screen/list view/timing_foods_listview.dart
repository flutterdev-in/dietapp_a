import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/list%20view/url_viewer_pc.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodsListViewforPC extends StatelessWidget {
  final bool editIconRequired;
  const FoodsListViewforPC({Key? key, this.editIconRequired = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Obx(() {
        if (pcc.currentTimingDR.value == userDR) {
          return const SizedBox();
        } else {
          return FirestoreListView<Map<String, dynamic>>(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            query: pcc.currentTimingDR.value
                .collection(fmos.foods)
                .where(fmos.isCamFood, isEqualTo: false)
                .orderBy(fmos.foodAddedTime, descending: false),
            itemBuilder: (context, doc) {
              Map<String, dynamic> foodMap = doc.data();
              FoodModel fm;

              fm = FoodModel.fromMap(foodMap);
              fm.docRef = doc.reference;

              return GFListTile(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                avatar: UrlAvatar(fm.rumm),
                title: Text(
                  fm.foodName,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                subTitle: (fm.notes == null || fm.notes == "")
                    ? null
                    : ExpandableText(
                        fm.notes ?? "",
                        expandText: "more",
                        collapseText: "show less",
                        style: TextStyle(
                          color: Colors.brown.shade400,
                        ),
                      ),
                onTap: () {
                  FocusScope.of(context).unfocus();

                  Get.to(URLviewerPC(rumm: fm.rumm));
                },
                icon: editIconRequired
                    ? InkWell(
                        child: const Icon(MdiIcons.playlistEdit),
                        onTap: () {
                          alertW(context, fm: fm);
                        },
                      )
                    : null,
              );
            },
          );
        }
      }),
    );
  }

  void alertW(
    BuildContext context, {
    required FoodModel fm,
  }) {
    Rx<String> tcName = "".obs;
    Rx<String> tcNotes = "".obs;

    alertDialogW(
      context,
      contentPadding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
      body: WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LimitedBox(
              maxHeight: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  // autofocus: true,
                  controller: TextEditingController(text: fm.foodName),
                  decoration: const InputDecoration(
                    labelText: "Food name",
                  ),
                  onChanged: (value) {
                    tcName.value = value;
                  },
                ),
              ),
            ),
            LimitedBox(
              maxHeight: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  controller: TextEditingController(text: fm.notes ?? ""),
                  decoration:
                      const InputDecoration(labelText: "Notes (optional)"),
                  onChanged: (value) {
                    tcNotes.value = value;
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(MdiIcons.close),
                  ),
                  onTap: () => Get.back(),
                ),
                // SizedBox(width: 5),
                ElevatedButton(
                  child: const Text("Delete"),
                  onPressed: () async {
                    Get.back();
                    await Future.delayed(const Duration(seconds: 1));
                    await fm.docRef!.delete();
                  },
                ),
                ElevatedButton(
                    child: const Text("Update"),
                    onPressed: () async {
                      String name =
                          tcName.value.isEmpty ? fm.foodName : tcName.value;
                      String? notes =
                          tcNotes.value.isEmpty ? fm.notes : tcNotes.value;
                      Get.back();
                      await Future.delayed(const Duration(seconds: 1));
                      if (pcc.currentDayDR.value.parent.id ==
                          admos.activeDaysPlan) {
                        await fm.docRef!.update({
                          fmos.foodName: name,
                          "$unIndexed.$notes0": notes,
                        });
                      } else {
                        await fm.docRef!.update({
                          fmos.foodName: name,
                          "$unIndexed.$notes": notes,
                        });
                      }
                    }),
                const SizedBox(width: 1),
              ],
            ),
          ],
        ),
        onWillPop: () async {
          Get.back();
          await Future.delayed(const Duration(milliseconds: 200));

          return true;
        },
      ),
    );
  }
}
