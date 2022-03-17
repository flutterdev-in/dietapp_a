import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CreateDietMainScreen extends StatelessWidget {
  const CreateDietMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: null, icon: Icon(MdiIcons.plus))],
      ),
      body: Column(
        children: [
          listDays(),
        ],
      ),
    );
  }

  Widget listDays() {
    return Text("data");
  }
}
