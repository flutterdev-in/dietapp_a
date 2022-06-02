import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:get/get.dart';

DietRoomController drc = DietRoomController();

class DietRoomController {
  final calendarDate = DateTime.now().obs;
  final currentDayDR = admos.activeDayDR(DateTime.now()).obs;
}
