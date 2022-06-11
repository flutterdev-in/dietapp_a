import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/fc_path_bar.dart';
import 'package:dietapp_a/x_customWidgets/web%20view/web_view_page.dart';
import 'package:dietapp_a/x_customWidgets/youtube/youtube_player_middle.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FolderViewMiddle extends StatelessWidget {
  final String folderName;
  final String homePath;
  const FolderViewMiddle(
      {Key? key, required this.folderName, required this.homePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(folderName)),
      body: Column(
        children: [
          FcPathBar(homePath: homePath),
          Obx(
            () => FirestoreListView<Map<String, dynamic>>(
              shrinkWrap: true,
              query: FirebaseFirestore.instance
                  .collection(fcc.currentPathCR.value)
                  .orderBy(fdcs.isFolder, descending: true)
                  .orderBy(fdcs.fieldTime, descending: false),
              itemBuilder: (context, snapshot) {
                //Rx variables

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
                    return const Icon(
                      MdiIcons.folder,
                      color: Colors.orange,
                    );
                  } else {
                    Widget avatar = GFAvatar(
                      shape: GFAvatarShape.standard,
                      size: GFSize.MEDIUM,
                      maxRadius: 20,
                      backgroundImage: NetworkImage(fdcm.rumm?.img ?? ""),
                    );
                    if (fdcm.rumm?.isYoutubeVideo ?? false) {
                      return Stack(
                        children: [
                          avatar,
                          Positioned(
                            child: Container(
                              color: Colors.white70,
                              child: const Icon(
                                MdiIcons.youtube,
                                color: Colors.red,
                                size: 15,
                              ),
                            ),
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
                  margin:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  avatar: avatarW(),
                  title: Text(
                    fdcm.foodName,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    if (fdcm.isFolder == true) {
                      fcc.currentPathCR.value =
                          snapshot.reference.path + fdcs.fcPathSeperator;

                      fcc.pathsListMaps.value.add(
                        {
                          fdcs.pathCR: snapshot.reference
                              .collection(fdcs.subCollections),
                          fdcs.pathCRstring: fcc.currentPathCR.value,
                          fdcs.fieldName: fdcm.foodName
                        },
                      );
                    } else if (fdcm.rumm?.isYoutubeVideo ?? false) {
                      Get.to(() =>
                          YoutubeVideoPlayerScreen(fdcm.rumm!, fdcm.foodName));
                    } else if (fdcm.rumm != null) {
                      Get.to(() => WebViewPage(fdcm.rumm!.url, fdcm.foodName));
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
