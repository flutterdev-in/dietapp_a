import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_widget.dart';
import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/x_customWidgets/image_viewer_screen.dart';
import 'package:dietapp_a/y_Active%20diet/functions/cam_pic_photo_upload.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_food_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../y_Active diet/controllers/active_plan_controller.dart';

class TimingViewHomeScreen extends StatelessWidget {
  final bool editingIconRequired;
  const TimingViewHomeScreen({Key? key, this.editingIconRequired = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() => FirestoreListView<Map<String, dynamic>>(
            shrinkWrap: true,
            query: apc.cuurentActiveDayDR.value
                .collection(atmos.timings)
                .orderBy(atmos.timingString),
            itemBuilder: (context, tQDS) {
              ActiveTimingModel atm = ActiveTimingModel.fromMap(tQDS.data());
              atm.docRef = tQDS.reference;
              return timingsView(context, atm);
            },
          )),
    );
  }

  Widget timingsView(BuildContext context, ActiveTimingModel atm) {
    RefUrlMetadataModel rumm = atm.prud ?? rummfos.constModel;

    return Card(
      child: Column(
        children: [
          GFListTile(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
            color: Colors.yellow.shade100,
            title: Text(
              atm.timingName,
              maxLines: 1,
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
            icon: Row(
              children: [
                IconButton(
                    onPressed: () async {
                      if (atm.docRef != null) {
                        await camPicPhotoUploadFunction(context, atm.docRef!);
                      }
                    },
                    icon: const Icon(MdiIcons.cameraPlus)),
                IconButton(
                    onPressed: () {}, icon: const Icon(MdiIcons.dotsVertical))
              ],
            ),
            // icon: Text(dtmos.displayTiming(atm.timingString)),
          ),
          if (atm.prud != null)
            RefURLWidget(
              refUrlMetadataModel: rumm,
              editingIconRequired: editingIconRequired,
            ),
          if (atm.plannedNotes != null && atm.plannedNotes != "")
            Card(
                child: SizedBox(
              child: Text(atm.plannedNotes!),
              width: double.maxFinite,
            )),
          camPictures(atm),
          FirestoreListView<Map<String, dynamic>>(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              query: atm.docRef!.collection(fmfpcfos.foods),
              itemBuilder: (context, doc) {
                ActiveFoodModel fm = ActiveFoodModel.fromMap(doc.data());

                return GFListTile(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  margin:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                  avatar: URLavatar(imgURL: fm.prud?.img, webURL: fm.trud?.url),
                  title: Text(fm.foodName, maxLines: 1),
                  subTitleText:
                      (fm.plannedNotes == null || fm.plannedNotes == "")
                          ? null
                          : fm.plannedNotes,
                );
              }),
        ],
      ),
    );
  }

  Widget camPictures(ActiveTimingModel atm) {
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
              height: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: listImgUrl.length,
                  itemBuilder: (context, index) {
                    var imgUrl = listImgUrl[index];

                    return InkWell(
                        child: Container(
                          color: Colors.amber,
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
                          Get.to(() => ImageViewerScreen(
                              listImgUrl: listImgUrl, initialIndex: index));
                        });
                  }),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
