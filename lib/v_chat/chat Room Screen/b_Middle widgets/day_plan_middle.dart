import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DayPlanMiddle extends StatelessWidget {
  final List<DayModel> listDays;
  final String? text;
  const DayPlanMiddle({
    Key? key,
    required this.listDays,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return CommonTopWidgetMiddle(
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: listDays.length,
        itemBuilder: (context, index) {
          DayModel dm = listDays[index];
          return Row(
            children: [
              FaIcon(FontAwesomeIcons.calendarDay),
              Text(
                  (listDays.length == 1) ? "Day plan" : "Day plan (${days[dm.dayIndex]})")
            ],
          );
        },
      ),
    );
  }
}
