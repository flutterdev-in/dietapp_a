import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodsListViewforPC extends StatelessWidget {
  const FoodsListViewforPC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Obx(() {
        return FirestoreListView<Map<String, dynamic>>(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          query: pcc.currentTimingDR.value
              .collection(fmfpcfos.foods)
              .orderBy(fmfpcfos.foodAddedTime, descending: false),
          itemBuilder: (context, doc) {
            Map<String, dynamic> foodMap = doc.data();
            FoodsModelForPlanCreation fm =
                FoodsModelForPlanCreation.fromMap(foodMap);

            return GFListTile(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
              avatar:
                  URLavatar(imgURL: fm.imgURL ?? "", webURL: fm.refURL ?? ""),
              title: Text(
                fm.foodName,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              subTitle: (fm.notes == null || fm.notes == "")
                  ? null
                  : LimitedBox(
                      maxHeight: 50,
                      child: SingleChildScrollView(
                        child: Text(
                          fm.notes ?? "",
                          softWrap: true,
                          textScaleFactor: 0.9,
                        ),
                      ),
                    ),
              icon: InkWell(
                child: Icon(MdiIcons.playlistEdit),
                onTap: () {
                  alertW(context, fm: fm, docRef: doc.reference);
                },
              ),
            );
          },
        );
      }),
    );
  }

  void alertW(BuildContext context,
      {required FoodsModelForPlanCreation fm,
      required DocumentReference<Map<String, dynamic>> docRef}) {
    Rx<String> tcName = "".obs;
    Rx<String> tcNotes = "".obs;

    alertDialogueW(
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
                  decoration: InputDecoration(
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(MdiIcons.close),
                  ),
                  onTap: () => Get.back(),
                ),
                // SizedBox(width: 5),
                ElevatedButton(
                  child: const Text("Delete"),
                  onPressed: () async {
                    Get.back();
                    await Future.delayed(Duration(seconds: 1));
                    await docRef.delete();
                  },
                ),
                ElevatedButton(
                    child: const Text("Modify"),
                    onPressed: () async {
                      String name =
                          tcName.value.isEmpty ? fm.foodName : tcName.value;
                      String? notes =
                          tcNotes.value.isEmpty ? fm.notes : tcNotes.value;
                      Get.back();
                      await Future.delayed(Duration(seconds: 1));
                      await docRef.update({
                        fmfpcfos.foodName: name,
                        fmfpcfos.notes: notes,
                      });
                    }),
                SizedBox(width: 1),
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
