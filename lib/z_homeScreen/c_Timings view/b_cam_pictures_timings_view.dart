import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/x_customWidgets/image_viewer_screen.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_food_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            var listImgUrl = snapshot.data!.docs
                .map((e) => ActiveFoodModel.fromMap(e.data()).trud!.img!)
                .toList();

            return SizedBox(
              height: 116,
              child: SingleChildScrollView(
                child: Row(
                  children: listImgUrl
                      .map((imgUrl) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl: imgUrl,
                                      errorWidget: (context, url, error) =>
                                          const Text("data"),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Get.to(
                                      () => ImageViewerScreen(imgUrl: imgUrl));
                                }),
                          ))
                      .toList(),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
