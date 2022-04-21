import 'package:flutter/material.dart';

class ActivePlansRowWidget extends StatelessWidget {
  const ActivePlansRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(onPressed: null, child: Text("data"))
      ],
    );
  }
}
