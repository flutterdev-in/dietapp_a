import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/w_Plan%20creation%20Screen/default_timing_model.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PlanCreationScreen extends StatelessWidget {
  PlanCreationScreen({Key? key}) : super(key: key);
  Rx<String> name = "".obs;
  Rx<String> day = "Sunday".obs;
  Rx<int> noOfWeeks = 4.obs;
  final listDefaultTimingModels = RxList<DefaultTimingModel>([]).obs;
  List<int> listnoOfWeeks = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Plan")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          shrinkWrap: true,
          children: [
            Card(
              child: LimitedBox(
                maxHeight: 80,
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Plan Name",
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            Card(
              child: LimitedBox(
                maxHeight: 150,
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: "Notes",
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            SizedBox(height: 25),
            Card(
              child: Row(
                children: [
                  Text("No of weeks", textScaleFactor: 1.2),
                  Expanded(child: SizedBox()),
                  SizedBox(
                    height: 60,
                    width: 70,
                    child: CupertinoPicker(
                      magnification: 0.9,
                      itemExtent: 40,
                      diameterRatio: 10,
                      scrollController:
                          FixedExtentScrollController(initialItem: 3),
                      onSelectedItemChanged: (v) {
                        noOfWeeks.value = listnoOfWeeks[v];
                      },
                      children: listnoOfWeeks
                          .map((e) => Center(
                                  child: Text(
                                e.toString(),
                                textScaleFactor: 1,
                              )))
                          .toList(),
                    ),
                  ),
                  SizedBox(width: 40)
                ],
              ),
            ),
            Card(
              child: Row(
                children: [
                  Text("Starting day\nof the week", textScaleFactor: 1.2),
                  Expanded(child: SizedBox()),
                  SizedBox(
                    width: 130,
                    child: Obx(() => DropdownButton<String>(
                        items: dropdownMenuItems(),
                        onChanged: (value) {
                          day.value = value ?? "Sunday";
                        },
                        value: day.value)),
                  ),
                ],
              ),
            ),
            timingsW(context),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> dropdownMenuItems() {
    List<String> days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];

    return days.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList();
  }

  Widget timingsW(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Default timings"),
              IconButton(
                  onPressed: () {
                    alertDialogueW(context, body: alertBodyW());
                  },
                  icon: const Icon(MdiIcons.plus)),
            ],
          ),
          Obx(
            () {
              List<DefaultTimingModel> listDTMsorted =
                  dtmos.foodTimingsListSort(listDefaultTimingModels.value);
              return ListView.builder(
                shrinkWrap: true,
                itemCount: listDTMsorted.length,
                itemBuilder: (context, index) {
                  DefaultTimingModel dftm = listDTMsorted[index];
                  String ampm = dftm.isAM ? "AM" : "PM";
                  String min = dftm.min == 0 ? "00" : dftm.min.toString();
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Text(
                                    dftm.timingName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                      child: Text("${dftm.hour} : $min $ampm"),
                                      alignment: Alignment.centerRight,
                                    ),
                                    flex: 4),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            splashColor: Colors.red,
                            child: const SizedBox(
                                child: Icon(MdiIcons.close, size: 17),
                                width: 20),
                            onTap: () async {
                              await Future.delayed(
                                  const Duration(milliseconds: 200));
                              listDefaultTimingModels.value.remove(dftm);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget alertBodyW() {
    List<int> listHours = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

    Rx<bool> isAM = true.obs;
    Rx<int> hour = 6.obs;
    Rx<int> mins = 30.obs;
    Rx<String> timingName = "".obs;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
          child: LimitedBox(
            maxHeight: 80,
            child: TextField(
              autofocus: true,
              maxLines: null,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: "Timing name",
              ),
              onChanged: (value) {
                timingName.value = value;
              },
            ),
          ),
        ),
        SizedBox(height: 30),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(MdiIcons.clockTimeEightOutline, size: 30),
            ),
            SizedBox(
              height: 60,
              width: 70,
              child: CupertinoPicker(
                magnification: 0.9,
                itemExtent: 40,
                diameterRatio: 10,
                scrollController: FixedExtentScrollController(initialItem: 5),
                onSelectedItemChanged: (v) {
                  hour.value = listHours[v];
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
              width: 70,
              child: CupertinoPicker(
                magnification: 0.9,
                itemExtent: 40,
                diameterRatio: 10,
                scrollController: FixedExtentScrollController(initialItem: 2),
                onSelectedItemChanged: (v) {
                  mins.value = [0, 15, 30, 45][v];
                },
                children: ["00", "15", "30", "45"]
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
              width: 70,
              child: CupertinoPicker(
                magnification: 0.9,
                itemExtent: 40,
                diameterRatio: 10,
                scrollController: FixedExtentScrollController(initialItem: 0),
                onSelectedItemChanged: (v) {
                  isAM.value = v == 0 ? true : false;
                },
                children: ["AM", "PM"]
                    .map((e) => Center(
                            child: Text(
                          e.toString(),
                          textScaleFactor: 1,
                        )))
                    .toList(),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () async {
                Get.back();
                await Future.delayed(const Duration(milliseconds: 600));
                listDefaultTimingModels.value.add(DefaultTimingModel(
                    timingName: timingName.value,
                    hour: hour.value,
                    min: mins.value,
                    isAM: isAM.value));
              },
              child: Text("Add")),
        )
      ],
    );
  }
}
