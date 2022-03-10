import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/bottom%20bars/buttons/d_delete_fc.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/bottom%20bars/buttons/r_rename_fc.dart';
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OnSelectedBottomBarForFoodCollection extends StatelessWidget {
  const OnSelectedBottomBarForFoodCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(MdiIcons.contentCopy)),
          IconButton(
              onPressed: () {}, icon: const Icon(MdiIcons.folderMoveOutline)),
          fcItemEditButton(),
          TextButton(
            child: const Text("Delete"),
            onPressed: () async {
              await deleteItemsFromFC(context);
            },
          ),
        ],
      ),
    );
  }
}
