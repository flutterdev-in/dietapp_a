import 'package:flutter/material.dart';

class DietViewChat extends StatelessWidget {
  const DietViewChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            DateTime today = DateTime.now();
            
            showDatePicker(
                context: context,
                currentDate: today,
                initialDate: today,
                firstDate: today,
                lastDate: today.add(const Duration(days: 60)),
                confirmText: "Activate from\nthis date");
          },
          child: const Text("Date"),
        )
      ],
    );
  }

   

}




