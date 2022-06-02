import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:get/get.dart';

import '../models/active_timing_model.dart';

ActivePlanController apc = ActivePlanController();

class ActivePlanController extends GetxController {
  final dt = DateTime.now().obs;
  final currentActiveDayDR = admos.activeDayDR(DateTime.now()).obs;
  final listCurrentActiveTimingModel = RxList<ActiveTimingModel>([]);
  final currentTimingString = "am0830".obs;
  final currentActiveTimingDR = userDR.obs;

  //
  DateTime dateDiffer(DateTime date, bool increase,
      {int differ = 1, String ymd = "m"}) {
    int? year = date.year;
    int? month = date.month;
    int? day = date.day;

    if (ymd == "m") {
      return DateTime(year, increase ? month + differ : month - differ, day);
    } else if (ymd == "y") {
      return DateTime(increase ? year + differ : year - differ, month, day);
    } else {
      return DateTime(year, month, increase ? day + differ : day - differ);
    }
  }

  Future<void> getCurrentActiveTimingModels(
      DocumentReference<Map<String, dynamic>> dayDR) async {
    await dayDR
        .collection(atmos.timings)
        .orderBy(atmos.timingString)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((tQS) {
      if (tQS.docs.isNotEmpty) {
        apc.listCurrentActiveTimingModel.value = tQS.docs.map((e) {
          var atm = ActiveTimingModel.fromMap(e.data());
          atm.docRef = e.reference;
          return atm;
        }).toList();
        apc.currentTimingString.value =
            apc.listCurrentActiveTimingModel[0].timingString;
      } else {
        apc.listCurrentActiveTimingModel.clear();
        apc.currentTimingString.value = "am0830";
      }
    });
  }
}
