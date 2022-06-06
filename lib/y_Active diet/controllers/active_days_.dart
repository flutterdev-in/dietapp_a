import 'package:dietapp_a/dartUtilities/day_weeks_functions.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:get/get.dart';

var mapDateADM = RxMap<DateTime, List<ActiveDayModel>>({}).obs;
var currentWeekString = dayWeekFunctions.weekString(DateTime.now()).obs;

