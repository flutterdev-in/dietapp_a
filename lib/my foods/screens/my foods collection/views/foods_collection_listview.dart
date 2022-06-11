import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/fc_useful_functions.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/x_customWidgets/expandable_text.dart';
import 'package:dietapp_a/x_customWidgets/web%20view/web_view_page.dart';
import 'package:dietapp_a/x_customWidgets/youtube/youtube_player_middle.dart';
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
        query: FirebaseFirestore.instance
            .collection(fcc.currentPathCR.value)
            .orderBy(fdcs.isFolder, descending: true)
            .orderBy(fdcs.fieldTime, descending: false),
        itemBuilder: (context, snapshot) {
          //Rx variables
          Rx<bool> isItemSelected = false.obs;

          Map<String, dynamic> fcMap = snapshot.data();

          FoodModel fdcm = FoodModel.fromMap(fcMap);

          fcc.currentsPathItemsMaps.value.addAll({
            snapshot.reference: {
              fdcs.isItemSelected: false,
              fdcs.itemIndex: fcc.currentsPathItemsMaps.value.length,
              fdcs.fcModel: fdcm
            }
          });
          Widget avatarW() {
            if (fdcm.isFolder == true) {
              return Icon(
                MdiIcons.folder,
                color: Colors.orange.shade300,
                size: 50,
              );
            } else {
              Widget avatar = fdcm.rumm?.isYoutubeVideo == true
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        width: 70,
                        child: CachedNetworkImage(imageUrl: fdcm.rumm!.img!),
                      ),
                    )
                  : GFAvatar(
                      child: fdcm.rumm?.img == null
                          ? const Icon(MdiIcons.note)
                          : null,
                      shape: GFAvatarShape.standard,
                      maxRadius: 30,
                      backgroundImage: fdcm.rumm?.img != null
                          ? CachedNetworkImageProvider(fdcm.rumm!.img!)
                          : null,
                    );
              if (fdcm.rumm?.isYoutubeVideo ?? false) {
                return Stack(
                  children: [
                    avatar,
                    Positioned(
                      child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(5)),
                          ),
                          child: Text(
                            fdcm.rumm!.youtubeVideoLength ?? "",
                            textScaleFactor: 0.9,
                            style: const TextStyle(color: Colors.white),
                          )),
                      right: 0,
                      bottom: 0,
                    )
                  ],
                );
              } else {
                return avatar;
              }
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
                    maxLines: 3,
                    expandText: "more",
                    collapseText: "show less",
                  ),
            icon: Obx(() {
              isItemSelected.value = fcc.currentsPathItemsMaps
                  .value[snapshot.reference]?[fdcs.isItemSelected];
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
                    fcc.currentsPathItemsMaps.value[snapshot.reference]
                        ?[fdcs.isItemSelected] = true;
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
                fcc.currentsPathItemsMaps.value[snapshot.reference]
                    ?[fdcs.isItemSelected] = isItemSelected.value;
                fcc.itemsSelectionCount.value = fcufs.countSelectedItems();
              } else if (fdcm.isFolder == true) {
                fcc.currentPathCR.value =
                    snapshot.reference.collection(fdcs.subCollections).path;

                fcc.pathsListMaps.value.add(
                  {
                    fdcs.pathCR:
                        snapshot.reference.collection(fdcs.subCollections),
                    fdcs.pathCRstring: fcc.currentPathCR.value,
                    fdcs.fieldName: fdcm.foodName
                  },
                );
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
              fcc.currentsPathItemsMaps.value[snapshot.reference]
                  ?[fdcs.isItemSelected] = true;
              fcc.itemsSelectionCount.value = fcufs.countSelectedItems();
            },
          );
        },
      ),
    );
  }
}
