import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/constants/adf_const_variables.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/add_food_controller.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/models/food_model_of_fire_food.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/widgets/website_open.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

//
class AppSearchListview extends StatelessWidget {
  const AppSearchListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (!adfc.searchString.value.contains(RegExp(r"\w+"))) {
          return Text("Type name of the food to search");
        } else {
          return StreamBuilder<QuerySnapshot>(
            stream: adfcv.fireFoodData
                .where(
                  "listSearchStrings",
                  arrayContains: adfc.searchString.value,
                )
                .limit(10)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error");
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return Text(
                    "Food is not available in DietApp, plz tap on search button in keyboard to view results in Youtube");
              } else {
                List<QueryDocumentSnapshot> listMaps = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: listMaps.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> foodMap =
                        listMaps[index].data() as Map<String, dynamic>;
                    FoodModelOfFireFood fmff =
                        FoodModelOfFireFood.fromMap(foodMap);

                    String matchedname = mostMatchedName(fmff.listSubNames)??"";

                    return GFListTile(
                      margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                      padding: EdgeInsets.all(0),
                      avatar: GFAvatar(
                        backgroundImage: NetworkImage(fmff.img150),
                      ),
                      titleText: matchedname,
                      subTitleText: fmff.sourceWebsite,
                      icon: IconButton(
                        icon: Obx(() => adfc.grossSelectedFCmodelMap.value
                                .containsKey(fmff.fID)
                            ? Icon(MdiIcons.checkboxMarkedCircle)
                            : Icon(MdiIcons.circleOutline)),
                        onPressed: () {
                          if (adfc.grossSelectedFCmodelMap.value
                              .containsKey(fmff.fID)) {
                            adfc.grossSelectedFCmodelMap.value.remove(fmff.fID);
                          } else {
                            adfc.grossSelectedFCmodelMap.value.addAll({
                              fmff.fID: {
                                adfcv.foodCollectionModel: FoodsCollectionModel(
                                  fieldName: matchedname,
                                  fieldTime: Timestamp.fromDate(DateTime.now()),
                                  isFolder: false,
                                  appFoodID: fmff.fID,
                                  imgURL: fmff.img150,
                                  webURL: fmff.sourceURL,
                                ),
                                adfcv.foodModelOfFireFood: fmff,
                                adfcv.matchedname:matchedname,

                              }
                            });
                          }
                        },
                      ),
                      onTap: () {
                        adfc.webFoodName.value = matchedname;
                        adfc.webURL.value = fmff.sourceURL;
                        Get.to(FoodWebView());
                      },
                    );
                  },
                );
              }
            },
          );
        }
      },
    );
  }

  String? mostMatchedName(List listNames) {
    String matchedName = listNames[0];
    int intl = 0;
    int sl = adfc.searchString.value.length;
    for (String i in listNames) {
      if (i.contains(adfc.searchString.value)) {
        int l = i.length - sl;
        if (l > intl) {
          intl = l;
          matchedName = i;
        }
      }
    }
    return matchedName.capitalizeFirst;
  }
}
