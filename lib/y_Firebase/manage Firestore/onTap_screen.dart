import 'package:flutter/material.dart';

class FireOnTap extends StatelessWidget {
  const FireOnTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(""),
          TextButton(onPressed: () {}, child: Text("Execute"))
        ],
      ),
    );
  }
}
