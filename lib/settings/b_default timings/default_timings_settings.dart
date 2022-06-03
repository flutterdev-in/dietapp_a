import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DefaultTimingsSettingsScreen extends StatelessWidget {
  const DefaultTimingsSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Default Food Timings"),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: defaultTimingsDR.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError || !snapshot.hasData) {
              return const Center(child: Text("Error while fetching data"));
            } else {
              var timingsDocMap = snapshot.data!.data() ?? {};
              List listTimingsMap = timingsDocMap[unIndexed] ?? [];

              List<DefaultTimingModel> listDefaultTimingModel = listTimingsMap
                  .map((e) => DefaultTimingModel.fromMapOnly2(e))
                  .toList();
              listDefaultTimingModel =
                  dtmos.foodTimingsListSort(listDefaultTimingModel);

              return Column(
                children: [
                  defaultTimingsList(context, listDefaultTimingModel),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          alertDialogW(context,
                              body:
                                  alertBodyW(context, listDefaultTimingModel));
                        },
                        child: const Text("Add timing")),
                  ),
                ],
              );
            }
          }),
    );
  }

  Widget defaultTimingsList(
      BuildContext context, List<DefaultTimingModel> listDefaultTimingModel) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: listDefaultTimingModel.length,
      itemBuilder: (context, index) {
        DefaultTimingModel dftm = listDefaultTimingModel[index];

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
                            child: Text(dtmos.displayTiming(dftm.timingString)),
                            alignment: Alignment.centerRight,
                          ),
                          flex: 4),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  splashColor: primaryColor,
                  child: const SizedBox(
                      child: Icon(MdiIcons.close, size: 17), width: 20),
                  onTap: () async {
                    var l0 = listDefaultTimingModel;
                    l0.remove(dftm);
                    List l1 = l0.map((e) => e.toMapOnly2()).toList();

                    await defaultTimingsDR.update({
                      unIndexed: l1,
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget alertBodyW(
      BuildContext context, List<DefaultTimingModel> listDefaultTimingModel) {
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
              decoration: const InputDecoration(
                labelText: "Timing name",
              ),
              onChanged: (value) {
                timingName.value = value;
              },
            ),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
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
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                Get.back();
                if (timingName.value.isNotEmpty) {
                  listDefaultTimingModel.add(DefaultTimingModel(
                      timingName: timingName.value,
                      timingString: dtmos.timingStringF(
                          hour.value, mins.value, isAM.value)));
                  listDefaultTimingModel =
                      dtmos.foodTimingsListSort(listDefaultTimingModel);
                  await defaultTimingsDR.update({
                    unIndexed: listDefaultTimingModel
                        .map((e) => e.toMapOnly2())
                        .toList(),
                  });
                }
              },
              child: const Text("Add")),
        )
      ],
    );
  }
}
