import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/fc_path_bar.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/c_chat_room_bottom.dart';
import 'package:dietapp_a/v_chat/controllers/chat_room_variables.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CollectionViewNavBar extends StatelessWidget {
  final ChatRoomModel crm;
  const CollectionViewNavBar(this.crm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    csv.selectedList.value.clear();
    return Column(
      children: [
        SizedBox(
            child: ChatRoomBottom(crm, isSuffixButtonsRequired: false),
            height: 60),
        const FcPathBar(),
        Expanded(
          child: Obx(
            () => FirestoreListView<Map<String, dynamic>>(
              shrinkWrap: true,
              query:
                  fcc.currentCR.value.orderBy(fmos.isFolder, descending: true),
              itemBuilder: (context, snapshot) {
                //Rx variables

                Map<String, dynamic> fcMap = snapshot.data();

                FoodModel fdcm = FoodModel.fromMap(fcMap);
                fdcm.docRef = snapshot.reference;

                Widget avatarW() {
                  if (fdcm.isFolder == true) {
                    return const Icon(
                      MdiIcons.folder,
                      color: Colors.orange,
                      size: 40,
                    );
                  } else {
                    Widget avatar = GFAvatar(
                      shape: GFAvatarShape.standard,
                      size: GFSize.MEDIUM,
                      maxRadius: 20,
                      backgroundImage: fdcm.rumm?.img != null
                          ? NetworkImage(fdcm.rumm!.img!)
                          : null,
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
                  icon: IconButton(
                    icon: Obx(
                      () {
                        if (csv.selectedList.value.contains(snapshot)) {
                          return const Icon(MdiIcons.checkboxMarkedCircle);
                        } else {
                          return const Icon(
                              MdiIcons.checkboxBlankCircleOutline);
                        }
                      },
                    ),
                    onPressed: () {
                      if (csv.selectedList.value.contains(snapshot)) {
                        csv.selectedList.value.remove(snapshot);
                      } else {
                        csv.selectedList.value.add(snapshot);
                      }
                    },
                  ),
                  onTap: () async {
                    if (fdcm.isFolder == true) {
                      csv.selectedList.value.clear();
                      await Future.delayed(const Duration(milliseconds: 200));
                      fcc.currentCR.value =
                          snapshot.reference.collection(fmos.subCollections);

                      fcc.listFoodModelsForPath.value.add(fdcm);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
