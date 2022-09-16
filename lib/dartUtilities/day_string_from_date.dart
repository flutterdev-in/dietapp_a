import 'package:intl/intl.dart';

String dayStringFromDate(DateTime date) {
  DateTime today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
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
