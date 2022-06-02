import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/x_customWidgets/multi_image_viewer_screen.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_food_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CamPicturesTimingsView extends StatelessWidget {
  final ActiveTimingModel atm;
  const CamPicturesTimingsView({Key? key, required this.atm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: atm.docRef!
            .collection(fmfpcfos.foods)
            .where(afmos.foodTypeCamPlanUp, isEqualTo: afmos.cam)
            .orderBy(afmos.foodAddedTime)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            var listAFM = snapshot.data!.docs.map((e) {
              var afm = ActiveFoodModel.fromMap(e.data());
              afm.docRef = e.reference;
              return afm;
            }).toList();

            return SizedBox(
              height: 116,
              child: Align(
                alignment: Alignment.topLeft,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: listAFM.length,
                    itemBuilder: (context, index) {
                      var afm = listAFM[index];
                      var time = DateFormat("hh:mm a")
                          .format(afm.takenTime ?? DateTime.now());
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                    imageUrl: afm.trud!.img!,
                                    errorWidget: (context, url, error) =>
                                        const Text("data"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Text(
                                        time,
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
                            AwesomeDialog(
                              context: context,
                              customHeader: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: afm.trud!.img!,
                                  errorWidget: (context, url, error) =>
                                      const Text("data"),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              dialogType: DialogType.WARNING,
                              title: 'Remove this image',
                              showCloseIcon: true,
                              btnCancelColor: Colors.green,
                              btnOkColor: Colors.red,
                              btnOkText: "Remove",
                              btnCancelOnPress: () {},
                              btnOkOnPress: () async {
                                await Future.delayed(
                                    const Duration(milliseconds: 500));
                                await afm.docRef!.delete();
                              },
                            ).show();
                          },
                        ),
                      );
                    }),
              ),
              // child: SingleChildScrollView(
              //   child: Row(
              //     children: listAFM.mapIndexed((index, afm) {
              //       var time = DateFormat("hh:mm a")
              //           .format(afm.takenTime ?? DateTime.now());
              //       return Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: InkWell(
              //             child: SizedBox(
              //               height: 100,
              //               width: 100,
              //               child: Stack(
              //                 alignment: Alignment.bottomRight,
              //                 children: [
              //                   ClipRRect(
              //                     borderRadius: BorderRadius.circular(5),
              //                     child: CachedNetworkImage(
              //                       imageUrl: afm.trud!.img!,
              //                       errorWidget: (context, url, error) =>
              //                           const Text("data"),
              //                     ),
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.all(1.0),
              //                     child: Container(
              //                       color: Colors.black,
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(1.0),
              //                         child: Text(
              //                           time,
              //                           textScaleFactor: 0.8,
              //                           style: const TextStyle(
              //                               color: Colors.white),
              //                         ),
              //                       ),
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //             onTap: () {
              //               Get.to(() => MultiImageViewerScreen(
              //                   listAFM: listAFM, initialIndex: index));
              //               // ImageViewerScreen(imgUrl: imgUrl));
              //             }),
              //       );
              //     }).toList(),
              //   ),
              // ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
