import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/fc_path_bar.dart';
import 'package:dietapp_a/x_customWidgets/web%20view/web_view_page.dart';
import 'package:dietapp_a/x_customWidgets/youtube/youtube_video_player.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FolderViewMiddle extends StatefulWidget {
  final String folderName;
  final String homePath;
  const FolderViewMiddle(
      {Key? key, required this.folderName, required this.homePath})
      : super(key: key);

  @override
  State<FolderViewMiddle> createState() => _FolderViewMiddleState();
}

class _FolderViewMiddleState extends State<FolderViewMiddle> {
  @override
  void dispose() {
    fcc.currentCR.value = userDR.collection(fmos.foodsCollection);
    fcc.listFoodModelsForPath.value.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentCR = FirebaseFirestore.instance.collection(widget.homePath).obs;

    return Scaffold(
      appBar: AppBar(title: Text(widget.folderName)),
      body: Column(
        children: [
          FcPathBar(homePath: widget.homePath),
          Expanded(
            child: Obx(
              () => FirestoreListView<Map<String, dynamic>>(
                query: currentCR.value
                    .orderBy(fmos.isFolder, descending: true)
                    .orderBy(fmos.foodAddedTime, descending: false),
                itemBuilder: (context, snapshot) {
                  FoodModel fm = FoodModel.fromMap(snapshot.data());
                  fm.docRef = snapshot.reference;

                  Widget avatarW() {
                    if (fm.isFolder == true) {
                      return const Icon(
                        MdiIcons.folder,
                        color: Colors.orange,
                      );
                    } else {
                      Widget avatar = GFAvatar(
                        shape: GFAvatarShape.standard,
                        size: GFSize.MEDIUM,
                        maxRadius: 20,
                        backgroundImage: fm.rumm?.img != null
                            ? NetworkImage(fm.rumm!.img!)
                            : null,
                      );
                      if (fm.rumm?.isYoutubeVideo ?? false) {
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
                      fm.foodName,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      if (fm.isFolder == true) {
                        currentCR.value =
                            snapshot.reference.collection(fmos.subCollections);

                        fcc.listFoodModelsForPath.value.add(fm);
                      } else if (fm.rumm?.isYoutubeVideo ?? false) {
                        Get.to(() =>
                            YoutubeVideoPlayerScreen(fm.rumm!, fm.foodName));
                      } else if (fm.rumm != null) {
                        Get.to(() => WebViewPage(fm.rumm!.url, fm.foodName));
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
