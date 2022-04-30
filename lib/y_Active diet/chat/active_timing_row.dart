import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Diet plans/b_Plan_Creation/models/default_timing_model.dart';
import '../models/active_day_model.dart';

class ActiveTimingsRow extends StatelessWidget {
  const ActiveTimingsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    apc.cuurentActiveDayDR.value =
        apc.cuurentActiveDayDR.value = admos.activeDayDR(dateNow);

    return SizedBox(
      width: Get.width,
      height: 37,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: apc.listCurrentActiveTimingModel.length,
                  itemBuilder: (context, index) {
                    ActiveTimingModel atm =
                        apc.listCurrentActiveTimingModel[index];

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 1, 0),
                      child: InkWell(
                        child: LimitedBox(
                          maxWidth: 65,
                          child: Obx(() => Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(1)),
                                  border: Border.all(color: Colors.black26),
                                  color: (apc.currentTimingString.value ==
                                          atm.timingString)
                                      ? Colors.deepPurple.shade200
                                      : Colors.white,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(atm.timingName,
                                            maxLines: 1, textScaleFactor: 0.9),
                                      ),
                                      Text(
                                          dtmos.displayTiming(atm.timingString),
                                          textScaleFactor: 0.9),
                                    ],
                                  )),
                                ),
                              )),
                        ),
                        onTap: () async {
                          apc.currentTimingString.value = atm.timingString;
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
