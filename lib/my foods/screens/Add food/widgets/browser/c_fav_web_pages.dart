import 'package:dietapp_a/hive%20Boxes/boxes.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/browser_controllers.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FavWebPages extends StatelessWidget {
  const FavWebPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(MdiIcons.folderHeartOutline),
            SizedBox(width: 20),
            Text(
              "Favorites",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      onTap: () async {
        alertDialogueW(
          context,
          contentPadding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
          body: SizedBox(
            height: 410,
            width: double.maxFinite,
            child: Obx(
              () {
                RxList rxhList = boxFavWebPages.keys.toList().obs;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: rxhList.length,
                  itemBuilder: (context, index) {
                    Map dataMap = boxFavWebPages.get(rxhList[index]);

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(2, 3, 3, 3),
                      child: Row(
                        children: [
                          GFAvatar(
                            shape: GFAvatarShape.standard,
                            size: GFSize.MEDIUM,
                            maxRadius: 20,
                            backgroundImage:
                                NetworkImage(dataMap["imageURL"] ?? ""),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: InkWell(
                              child: Text(
                                dataMap["title"],
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () async {
                                Get.back();
                                await bc.loadURl(dataMap["webURL"]);
                              },
                            ),
                            flex: 8,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: InkWell(
                                child: Icon(
                                  MdiIcons.minusCircleOutline,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  rxhList.removeAt(index);
                                  boxFavWebPages.deleteAt(index);
                                }),
                            flex: 1,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
