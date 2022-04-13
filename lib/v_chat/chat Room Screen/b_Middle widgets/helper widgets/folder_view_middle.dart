import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/fc_path_bar.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/helper%20widgets/web_page_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/helper%20widgets/youtube_player_middle.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
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
                Rx<bool> isItemSelected = false.obs;

                Map<String, dynamic> fcMap = snapshot.data();

                FoodsCollectionModel fdcm = FoodsCollectionModel.fromMap(fcMap);

                fcc.currentsPathItemsMaps.value.addAll({
                  snapshot.reference: {
                    fdcs.isItemSelected: false,
                    fdcs.itemIndex: fcc.currentsPathItemsMaps.value.length,
                    fdcs.fcModel: fdcm
                  }
                });
                Widget avatarW() {
                  if (fdcm.isFolder) {
                    return const Icon(
                      MdiIcons.folder,
                      color: Colors.orange,
                    );
                  } else {
                    Widget avatar = GFAvatar(
                      shape: GFAvatarShape.standard,
                      size: GFSize.MEDIUM,
                      maxRadius: 20,
                      backgroundImage: NetworkImage(fdcm.imgURL ?? ""),
                    );
                    if (fdcm.webURL?.contains("youtube.com/watch?v=") ??
                        false) {
                      return Stack(
                        children: [
                          avatar,
                          Positioned(
                            child: Container(
                              color: Colors.white70,
                              child: Icon(
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
                    fdcm.fieldName,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    if (fdcm.isFolder) {
                      fcc.currentPathCR.value =
                          snapshot.reference.path + fdcs.fcPathSeperator;

                      fcc.pathsListMaps.value.add(
                        {
                          fdcs.pathCR: snapshot.reference
                              .collection(fdcs.subCollections),
                          fdcs.pathCRstring: fcc.currentPathCR.value,
                          fdcs.fieldName: fdcm.fieldName
                        },
                      );
                    } else if (fdcm.webURL?.contains("youtube.com") ?? false) {
                      Get.to(() => YoutubePlayerMiddle(webURL: fdcm.webURL!, title: fdcm.fieldName));
                    } else if (fdcm.webURL != null) {
                      Get.to(() => WebPageMiddle(
                          webURL: fdcm.webURL!, title: fdcm.fieldName));
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
