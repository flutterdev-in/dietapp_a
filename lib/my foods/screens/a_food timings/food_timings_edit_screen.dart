import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/my%20foods/screens/a_food%20timings/food_timing_model.dart';
import 'package:dietapp_a/my%20foods/screens/a_food%20timings/functions/food_timings_list_sort.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:dietapp_a/x_customWidgets/stream_builder_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodTimingsScreen extends StatelessWidget {
  FoodTimingsScreen({Key? key}) : super(key: key);
  TextEditingController tc = TextEditingController();
  final String userDocuments = "userDocuments";
  final String foodTimings = "foodTimings";
  final String foodTimingsList = "foodTimingsList";
  Rx<int> rxHours = 6.obs;
  Rx<int> rxMins = 30.obs;
  Rx<int> rxDeviation = 45.obs;
  Rx<bool> rxIsAm = true.obs;

  RxList rxFoodTimingsListMaps = [].obs;
  RxMap rxFoodTimingsMap =
      FoodTimingModel(name: "", hours: 6, mins: 0, deviation: 45, isAm: true)
          .toMap()
          .obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Timings"),
        actions: [
          IconButton(
            onPressed: () {
              FoodTimingModel ftm0 = FoodTimingModel.fromMap(rxFoodTimingsMap);
              String name = ftm0.name;
              int hours = ftm0.hours;
              String minS = ftm0.mins == 0 ? "00" : ftm0.mins.toString();

              String ampm = ftm0.isAm ? "am" : "pm";
              tc.text = name;
              dialogW(
                context: context,
                isAddNew: true,
                name: name,
                hours: hours,
                mins: ftm0.mins,
                isAm: ftm0.isAm,
                deviation: ftm0.deviation,
              );
            },
            icon: const Icon(MdiIcons.plus),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(uss.users)
              .doc(userUID)
              .collection(userDocuments)
              .doc(foodTimings)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            var data = docStreamReturn(context, snapshot, widType: "");

            if (data is Map) {
              List foodTimingsListMaps = data[foodTimingsList];

              foodTimingsListMaps = foodTimingsListSort(foodTimingsListMaps);
              rxFoodTimingsListMaps.value = foodTimingsListMaps;
              return ListView.builder(
                itemCount: foodTimingsListMaps.length,
                itemBuilder: (context, index) {
                  FoodTimingModel ftm =
                      FoodTimingModel.fromMap(foodTimingsListMaps[index]);

                  String name = ftm.name;
                  int hours = ftm.hours;
                  String minS = ftm.mins == 0 ? "00" : ftm.mins.toString();
                  String deviationS =
                      ftm.deviation == 0 ? "00" : ftm.deviation.toString();
                  String ampm = ftm.isAm ? "am" : "pm";

                  return ListTile(
                    title: Text(name),
                    trailing:
                        Text("$hours : $minS $ampm \u00B1 ${deviationS}m"),
                    onTap: () {
                      // rxFoodTimingsMap.value = foodTimingsListMaps[index];
                      tc.text = name;
                      dialogW(
                        isAddNew: false,
                        context: context,
                        name: name,
                        hours: hours,
                        mins: ftm.mins,
                        isAm: ftm.isAm,
                        deviation: ftm.deviation,
                        listIndex: index,
                      );
                    },
                  );
                },
              );
            } else {
              return data;
            }
          }),
    );
  }

  dialogW({
    required BuildContext context,
    required bool isAddNew,
    required String name,
    required int hours,
    required int mins,
    required int deviation,
    required bool isAm,
    int? listIndex,
  }) {
    rxHours.value = hours;
    rxMins.value = mins;
    rxIsAm.value = isAm;
    rxDeviation.value = deviation;

    List<int> listHours = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    List<int> listMins = [0, 15, 30, 45];
    List<int> listDeviations = [0, 15, 30, 45, 60, 75, 90];

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        contentPadding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 24.0),
        scrollable: true,
        actionsAlignment: MainAxisAlignment.start,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autofocus: isAddNew,
                controller: tc,
                decoration: const InputDecoration(labelText: "Name"),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Timing",
                textScaleFactor: 0.9,
                style: TextStyle(color: Colors.black87),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 55,
                  child: CupertinoPicker(
                    magnification: 0.9,
                    itemExtent: 40,
                    diameterRatio: 10,
                    scrollController:
                        FixedExtentScrollController(initialItem: hours - 1),
                    onSelectedItemChanged: (v) {
                      rxHours.value = listHours[v];
                    },
                    children: listHours
                        .map((e) => Center(
                                child: Text(
                              e.toString(),
                              textScaleFactor: 1,
                            )))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 55,
                  child: CupertinoPicker(
                    itemExtent: 40,
                    diameterRatio: 10,
                    scrollController: FixedExtentScrollController(
                        initialItem: listMins.indexOf(mins)),
                    onSelectedItemChanged: (v) {
                      rxMins.value = listMins[v];
                    },
                    children: listMins
                        .map((e) => Center(
                                child: Text(
                              e == 0 ? "00" : e.toString(),
                              textScaleFactor: 0.9,
                            )))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 55,
                  child: CupertinoPicker(
                    itemExtent: 40,
                    diameterRatio: 10,
                    scrollController:
                        FixedExtentScrollController(initialItem: isAm ? 0 : 1),
                    onSelectedItemChanged: (v) {
                      rxIsAm.value = v == 0 ? true : false;
                    },
                    children: ["am", "pm"]
                        .map((e) => Center(
                                child: Text(
                              e,
                              textScaleFactor: 0.9,
                            )))
                        .toList(),
                  ),
                ),
                Text("\u00B1"),
                SizedBox(
                  height: 60,
                  width: 55,
                  child: CupertinoPicker(
                    itemExtent: 40,
                    diameterRatio: 10,
                    scrollController: FixedExtentScrollController(
                        initialItem: listMins.indexOf(deviation)),
                    onSelectedItemChanged: (v) {
                      rxDeviation.value = listDeviations[v];
                    },
                    children: listDeviations
                        .map((e) => Center(
                                child: Text(
                              e == 0 ? "00" : e.toString(),
                              textScaleFactor: 0.9,
                            )))
                        .toList(),
                  ),
                ),
                Text("m"),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GFButton(
                  child: Text(isAddNew ? "Cancle" : "Delete"),
                  color: Colors.black87,
                  onPressed: () async {
                    if (isAddNew) {
                      Get.back();
                    } else {
                      Get.back();
                      rxFoodTimingsListMaps.removeAt(listIndex ?? 0);
                      await Future.delayed(Duration(milliseconds: 600));
                      await FirebaseFirestore.instance
                          .collection(uss.users)
                          .doc(userUID)
                          .collection(userDocuments)
                          .doc(foodTimings)
                          .update(({foodTimingsList: rxFoodTimingsListMaps}))
                          .onError((error, stackTrace) => null);
                    }
                  },
                ),
                GFButton(
                  child: Text(isAddNew ? "Add" : "Modify"),
                  color: Colors.black87,
                  onPressed: () async {
                    Map foodTimingsMap = FoodTimingModel(
                      name: tc.text == ""
                          ? "${rxHours.value} : ${rxMins.value} ${rxIsAm.value ? "am" : "pm"} \u00B1 ${rxDeviation.value}m"
                          : tc.text,
                      hours: rxHours.value,
                      mins: rxMins.value,
                      deviation: rxDeviation.value,
                      isAm: rxIsAm.value,
                    ).toMap();
                    if (isAddNew) {
                      rxFoodTimingsListMaps.add(foodTimingsMap);
                    } else {
                      rxFoodTimingsListMaps[listIndex ?? 0] = foodTimingsMap;
                    }

                    Get.back();
                    await Future.delayed(const Duration(milliseconds: 600));
                    await FirebaseFirestore.instance
                        .collection(uss.users)
                        .doc(userUID)
                        .collection(userDocuments)
                        .doc(foodTimings)
                        .update(({
                          foodTimingsList:
                              rxFoodTimingsListMaps.toSet().toList()
                        }))
                        .onError((error, stackTrace) => null);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
