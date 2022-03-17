import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

addNamePopUpWidget(BuildContext context,
    {EdgeInsets insetPadding = const EdgeInsets.all(10),
    EdgeInsetsGeometry contentPadding =
        const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 24.0),
    bool scrollable = true,
    MainAxisAlignment? actionsAlignment = MainAxisAlignment.start,
    required String lableText,
    required ValueChanged<String> onChanged,
    required void Function() onTap}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      insetPadding: insetPadding,
      contentPadding: contentPadding,
      scrollable: true,
      actionsAlignment: actionsAlignment,
      content: LimitedBox(
        maxHeight: 170,
        child: Stack(
          children: [
            Positioned(
              child: InkWell(
                child: Container(
                  color: Colors.red.shade50,
                  child: const Icon(MdiIcons.close),
                  width: 20,
                  height: 20,
                ),
                onTap: () => Get.back(),
              ),
              top: 3,
              right: 3,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    autofocus: true,
                    onChanged: (tcName) {
                      onChanged(tcName);
                    },
                    decoration: InputDecoration(
                      labelText: lableText,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: ()=>onTap,
                    child: Text("Continue")),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
