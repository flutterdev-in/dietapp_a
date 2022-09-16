import 'package:flutter/material.dart';

class ActivePlansRowWidget extends StatelessWidget {
  const ActivePlansRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [ElevatedButton(onPressed: null, child: Text("data"))],
    );
  }
}
