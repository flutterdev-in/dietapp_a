import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:intl/intl.dart';

String dayStringFromDate(DateTime date) {
  DateTime today = DateTime(dateNow.year, dateNow.month, dateNow.day);
  DateTime slectedDate = DateTime(date.year, date.month, date.day);
  if (slectedDate.difference(today).inDays == 0) {
    return "Today";
  } else if (slectedDate.difference(today).inDays == -1) {
    return "Yesterday";
  } else if (slectedDate.difference(today).inDays == 1) {
    return "Tomorrow";
  } else {
    return DateFormat("dd MMM yyyy").format(slectedDate);
  }
}
