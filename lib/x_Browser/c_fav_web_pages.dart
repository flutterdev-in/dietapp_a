import 'package:dietapp_a/hive%20Boxes/boxes.dart';
import 'package:dietapp_a/x_Browser/controllers/browser_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

RxList rxFavWebPages = [].obs;

// class FavWebPages extends StatelessWidget {
//   const FavWebPages({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: SizedBox(
//         height: 45,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: const [
//             Icon(MdiIcons.folderHeartOutline),
//             SizedBox(width: 20),
//             Text(
//               "Favorites",
//               style: TextStyle(color: Colors.white),
//             )
//           ],
//         ),
//       ),
//       onTap: () async {
//         alertDialogueW(
//           context,
//           contentPadding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
//           body: SizedBox(
//             height: 410,
//             width: double.maxFinite,
//             child: Obx(
//               () {
//                 rxFavWebPages.value = boxFavWebPages.keys.toList().obs;
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: rxFavWebPages.length,
//                   itemBuilder: (context, index) {
//                     Map dataMap = boxFavWebPages.get(rxFavWebPages[index]);

//                     return Padding(
//                       padding: const EdgeInsets.fromLTRB(2, 3, 3, 3),
//                       child: Row(
//                         children: [
//                           GFAvatar(
//                             shape: GFAvatarShape.standard,
//                             size: GFSize.MEDIUM,
//                             maxRadius: 20,
//                             backgroundImage:
//                                 NetworkImage(dataMap["imageURL"] ?? ""),
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Expanded(
//                             child: InkWell(
//                               child: Text(
//                                 dataMap["title"],
//                                 softWrap: true,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               onTap: () async {
//                                 Get.back();
//                                 Get.back();
//                                 await bc.loadURl(dataMap["webURL"]);
//                               },
//                             ),
//                             flex: 8,
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Expanded(
//                             child: InkWell(
//                                 child: const Icon(
//                                   MdiIcons.minusCircleOutline,
//                                   color: Colors.black,
//                                 ),
//                                 onTap: () {
//                                   rxFavWebPages.removeAt(index);
//                                   boxFavWebPages.deleteAt(index);
//                                 }),
//                             flex: 1,
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class FavWebPagesListView extends StatelessWidget {
  const FavWebPagesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 410,
      width: double.maxFinite,
      child: Obx(
        () {
          rxFavWebPages = boxFavWebPages.keys.toList().obs;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: rxFavWebPages.length,
            itemBuilder: (context, index) {
              Map dataMap = boxFavWebPages.get(rxFavWebPages[index]);

              return Padding(
                padding: const EdgeInsets.fromLTRB(2, 3, 3, 3),
                child: Row(
                  children: [
                    GFAvatar(
                      shape: GFAvatarShape.standard,
                      size: GFSize.MEDIUM,
                      maxRadius: 20,
                      backgroundImage: NetworkImage(dataMap["imageURL"] ?? ""),
                    ),
                    const SizedBox(
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
                          Get.back();
                          await bc.loadURl(dataMap["webURL"]);
                        },
                      ),
                      flex: 8,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                          child: const Icon(
                            MdiIcons.minusCircleOutline,
                            color: Colors.black,
                          ),
                          onTap: () {
                            rxFavWebPages.removeAt(index);
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
    );
  }
}

class FavWebPagesModel {
  final String webURL;
  final String title;
  final String imageURL;
  FavWebPagesModel({
    required this.webURL,
    required this.title,
    required this.imageURL,
  });

  Map<String, dynamic> toMap() {
    return {
      "webURL": webURL,
      "title": title,
      "imageURL": imageURL,
    };
  }

  factory FavWebPagesModel.fromMap(Map dataMap) {
    return FavWebPagesModel(
      webURL: dataMap["webURL"],
      title: dataMap["title"],
      imageURL: dataMap["imageURL"],
    );
  }
}
