import 'package:flutter/material.dart';

class DPbasicEntriesScreen extends StatelessWidget {
  const DPbasicEntriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        children: [
          planName(),
        ],
      ),
    );
  }

  Widget planName() {
    return TextField();
  }
}
