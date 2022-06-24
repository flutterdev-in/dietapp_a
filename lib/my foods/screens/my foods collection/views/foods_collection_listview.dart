import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/fc_useful_functions.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/x_customWidgets/expandable_text.dart';
import 'package:dietapp_a/x_customWidgets/web%20view/web_view_page.dart';
import 'package:dietapp_a/x_customWidgets/youtube/youtube_video_player.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodsCollectionListView extends StatelessWidget {
  const FoodsCollectionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FirestoreListView<Map<String, dynamic>>(
        shrinkWrap: true,
        query: fcc.currentCR.value
            .orderBy(fmos.isFolder, descending: true)
            .orderBy(fmos.foodAddedTime, descending: false),
        itemBuilder: (context, snapshot) {
          //Rx variables
          Rx<bool> isItemSelected = false.obs;

          FoodModel fdcm = FoodModel.fromMap(snapshot.data());
          fdcm.docRef = snapshot.reference;

          fcc.currentPathMapFoodModels.value[fdcm] = false;
          Widget avatarW() {
            if (fdcm.isFolder == true) {
              return Icon(
                MdiIcons.folder,
                color: Colors.orange.shade300,
                size: 50,
              );
            } else {
              return UrlAvatar(fdcm.rumm);
            }
          }

          return GFListTile(
            padding: const EdgeInsets.fromLTRB(0, 5, 8, 0),
            margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            avatar: avatarW(),
            subTitle: fdcm.notes != null
                ? expText(fdcm.notes!, collapseOnTextTap: false)
                : null,
            title: fdcm.notes != null
                ? Text(
                    fdcm.foodName,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                : ExpandableText(
                    fdcm.foodName,
                    maxLines: 2,
                    expandText: "more",
                    collapseText: "show less",
                  ),
            icon: Obx(() {
              isItemSelected.value =
                  fcc.currentPathMapFoodModels.value[fdcm] ?? false;
              if (fcc.isSelectionStarted.value) {
                if (fcc.isSelectAll.value) {
                  return const Icon(MdiIcons.checkboxMarkedCircle);
                } else if (fcc.isUnselectAll.value) {
                  return const Icon(MdiIcons.checkboxBlankCircleOutline);
                } else if (isItemSelected.value) {
                  return const Icon(MdiIcons.checkboxMarkedCircle);
                } else if (!isItemSelected.value) {
                  return const Icon(MdiIcons.checkboxBlankCircleOutline);
                } else {
                  return const SizedBox();
                }
              } else {
                return InkWell(
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                    child: Icon(
                      MdiIcons.circleOutline,
                      size: 9,
                      color: Colors.green,
                    ),
                  ),
                  onTap: () {
                    fcc.isSelectAll.value = false;
                    fcc.isUnselectAll.value = false;
                    fcc.currentPathMapFoodModels.value[fdcm] = true;
                    fcc.isSelectionStarted.value = true;
                    fcc.itemsSelectionCount.value = fcufs.countSelectedItems();
                  },
                );
              }
            }),
            onTap: () {
              fcc.isSelectAll.value = false;
              fcc.isUnselectAll.value = false;
              if (fcc.isSelectionStarted.value) {
                isItemSelected.value = !isItemSelected.value;
                fcc.currentPathMapFoodModels.value[fdcm] = isItemSelected.value;
                fcc.itemsSelectionCount.value = fcufs.countSelectedItems();
              } else if (fdcm.isFolder == true) {
                fcc.currentCR.value =
                    snapshot.reference.collection(fdcs.subCollections);

                fcc.listFoodModelsForPath.value.add(fdcm);
              } else {
                if (fdcm.rumm?.isYoutubeVideo ?? false) {
                  Get.to(() =>
                      YoutubeVideoPlayerScreen(fdcm.rumm!, fdcm.foodName));
                } else if (fdcm.rumm?.url != null) {
                  Get.to(() => WebViewPage(fdcm.rumm!.url, fdcm.foodName));
                }
              }
            },
            onLongPress: () {
              fcc.isSelectAll.value = false;
              fcc.isUnselectAll.value = false;
              fcc.isSelectionStarted.value = true;
              isItemSelected.value = true;
              fcc.currentPathMapFoodModels.value[fdcm] = true;
              fcc.itemsSelectionCount.value = fcufs.countSelectedItems();
            },
          );
        },
      ),
    );
  }
}
