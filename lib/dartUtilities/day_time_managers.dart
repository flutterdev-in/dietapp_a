List<DateTime> getWeekMondays() {
  List<DateTime> listMondays = [];
  var today = DateTime.now();

  while (today.weekday != DateTime.monday) {
    listMondays.add(today);
    today = today.add(const Duration(days: 1));
  }

  for (var i in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]) {
    listMondays.add(today.add(Duration(days: (7 * i))));
  }

  return listMondays;
}
