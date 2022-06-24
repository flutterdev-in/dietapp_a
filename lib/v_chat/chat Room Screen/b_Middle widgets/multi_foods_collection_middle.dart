import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/helper%20widgets/folder_view_middle.dart';
import 'package:dietapp_a/x_customWidgets/web%20view/web_view_page.dart';
import 'package:dietapp_a/x_customWidgets/youtube/youtube_video_player.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MultiFoodsCollectionMiddle extends StatelessWidget {
  final List<FoodModel> listFDCM;
  final String? text;
  const MultiFoodsCollectionMiddle({
    Key? key,
    required this.listFDCM,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonTopWidgetMiddle(
        text: text,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: chatFoodCollectionColor,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: listFDCM.length,
                itemBuilder: (context, index) {
                  FoodModel fdcm = listFDCM[index];

                  if (fdcm.isFolder == true) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        child: Row(
                          children: [
                            const Icon(MdiIcons.folderOutline,
                                color: Colors.white, size: 50),
                            const SizedBox(width: 10),
                            Text(fdcm.foodName,
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                        onTap: () {
                          if (fdcm.docRef != null) {
                            fcc.listFoodModelsForPath.value.clear();
                            fcc.currentCR.value =
                                fdcm.docRef!.collection(fdcs.subCollections);

                            Get.to(() => FolderViewMiddle(
                                  folderName: fdcm.foodName,
                                  homePath: fcc.currentCR.value.path,
                                ));
                          }
                        },
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          child: Row(
                            children: [
                              UrlAvatar(fdcm.rumm),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  fdcm.foodName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            if (fdcm.rumm?.isYoutubeVideo ?? false) {
                              Get.to(() => YoutubeVideoPlayerScreen(
                                  fdcm.rumm!, fdcm.foodName));
                            } else if (fdcm.rumm != null) {
                              Get.to(() =>
                                  WebViewPage(fdcm.rumm!.url, fdcm.foodName));
                            }
                          }),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
