import 'package:dietapp_a/v_chat/chat%20Search/chat_seach_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Widget chatSearchButton = IconButton(
  onPressed: () {
    Get.to(
      () => const ChatSearchScreen(),
      opaque: false,
      transition: Transition.leftToRightWithFade,
    );
  },
  icon: const Icon(MdiIcons.magnify),
);
