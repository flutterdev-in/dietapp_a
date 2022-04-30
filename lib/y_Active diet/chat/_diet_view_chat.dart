import 'package:dietapp_a/y_Active%20diet/chat/active_timing_view.dart';
import 'package:dietapp_a/y_Active%20diet/chat/month_calander.dart';
import 'package:flutter/material.dart';

class DietViewChat extends StatelessWidget {
  const DietViewChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        MonthCalander(),
        ActiveTimingsView(),
      ],
    );
  }
}
