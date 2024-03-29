import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:dietapp_a/x_customWidgets/multi_image_viewer_screen.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

class CamPicturesTimingsView extends StatelessWidget {
  final TimingModel atm;
  final bool isActionAllowed;
  const CamPicturesTimingsView(this.atm,
      {Key? key, required this.isActionAllowed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: atm.docRef!
            .collection(fmos.foods)
            .where(fmos.isCamFood, isEqualTo: true)
            .orderBy(fmos.foodAddedTime)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            var listAFM = snapshot.data!.docs.map((e) {
              var afm = FoodModel.fromMap(e.data());
              afm.docRef = e.reference;
              return afm;
            }).toList();

            return SizedBox(
              height: 100,
              child: Align(
                alignment: Alignment.topLeft,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: listAFM.length,
                    itemBuilder: (context, index) {
                      var afm = listAFM[index];
                      var time = DateFormat("hh:mm a")
                          .format(afm.foodTakenTime ?? DateTime.now());
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          child: SizedBox(
                            height: 90,
                            width: 90,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl: afm.rumm!.img!,
                                    errorWidget: (context, url, error) =>
                                        const Text("data"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        time.toLowerCase(),
                                        textScaleFactor: 0.8,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            Get.to(() => MultiImageViewerScreen(
                                listAFM: listAFM, initialIndex: index));
                          },
                          onLongPress: () {
                            if (isActionAllowed) {
                              alertDialogW(context,
                                  barrierDismissible: true,
                                  insetPadding: EdgeInsets.fromLTRB(
                                      mdWidth(context) * 1 / 6,
                                      0,
                                      mdWidth(context) * 1 / 6,
                                      0),
                                  body: Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: afm.rumm!.img!,
                                        errorWidget: (context, url, error) =>
                                            const Text("data"),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text("Remove this image"),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GFButton(
                                              color: Colors.green,
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text("Cancle")),
                                          GFButton(
                                              color: Colors.red,
                                              onPressed: () async {
                                                Get.back();
                                                await Future.delayed(
                                                    const Duration(seconds: 1));
                                                afm.docRef!.delete();
                                              },
                                              child: const Text("Remove")),
                                        ],
                                      )
                                    ],
                                  ));
                            }
                          },
                        ),
                      );
                    }),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
