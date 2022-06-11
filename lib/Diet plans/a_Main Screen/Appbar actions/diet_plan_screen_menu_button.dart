import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuButtonDietPlanScreen extends StatelessWidget {
  const MenuButtonDietPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton(
        padding: const EdgeInsets.all(10.0),
        // color: Colors.black87,
        child: const Icon(MdiIcons.dotsVertical, color: Colors.white),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: deleteLast(),
            ),
          ];
        },
      ),
    );
  }

  Widget deleteLast() {
    return InkWell(
      child: SizedBox(
        height: 45,
        child: Row(
          children: const [
            SizedBox(width: 15),
            Text(
              "Fav Names",
            ),
          ],
        ),
      ),
      onTap: () async {},
    );
  }
}
