import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:intl/intl.dart';

final ActiveDayModelObjects admos = ActiveDayModelObjects();

class ActiveDayModelObjects {
  final String activeDaysPlan = "activeDaysPlan";
  final DateFormat dayFormat = DateFormat("yyyyMMdd");

  //
  String activeDayStringFromDate(DateTime date) {
    return dayFormat.format(date);
  }

  //
  DocumentReference<Map<String, dynamic>> activeDayDR(
      DateTime date, String personUID) {
    String dateString = activeDayStringFromDate(date);
    return FirebaseFirestore.instance
        .collection(users)
        .doc(personUID)
        .collection(admos.activeDaysPlan)
        .doc(dateString);
  }

  //
  DateTime dateFromDayDR(DocumentReference<Map<String, dynamic>> dayDR) {
    return DateTime.parse(dayDR.id);
  }

  //
  DateTime dateZeroTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
