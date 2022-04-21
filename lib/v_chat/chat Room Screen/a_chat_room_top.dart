import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/v_chat/constants/chat_const_variables.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';
import 'package:dietapp_a/x_customWidgets/stream_builder_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Rx<bool> isChatPersonOnChat = false.obs;

class ChatRoomAppBar extends StatelessWidget {
  const ChatRoomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              MdiIcons.arrowLeft,
              color: Colors.white,
            )),
        details(),
      ],
    );
  }
}

Widget ifChatOpen({required Widget elseW}) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(crs.chatRooms)
          .doc(thisChatDocID.value)
          .snapshots(),
      builder: (c, AsyncSnapshot<DocumentSnapshot> d) {
        var data = docStreamReturn(c, d, widType: "tile");
        isChatPersonOnChat.value = false;
        if (data is Map) {
          if (data[thisChatPersonUID][crs.isThisChatOpen]) {
            isChatPersonOnChat.value = true;
          }
        }
        return Obx(() => isChatPersonOnChat.value
            ? const Text(
                "on chat",
                style: TextStyle(color: Colors.white60, fontSize: 14),
              )
            : elseW);
      });
}

Widget details() {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(uss.users)
          .doc(thisChatPersonUID.value)
          .snapshots(),
      builder: (c, AsyncSnapshot<DocumentSnapshot> d) {
        var data = docStreamReturn(c, d, widType: "tile");
        if (data is Map) {
          UserWelcomeModel uwm = UserWelcomeModel.fromMap(data);

          return Row(
            children: [
              GFAvatar(
                maxRadius: 18,
                size: GFSize.SMALL,
                backgroundImage: NetworkImage(uwm.photoURL!),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uwm.displayName,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  ifChatOpen(
                    elseW: Text(uwm.isActive ? "active" : "inactive",
                        style: const TextStyle(
                            color: Colors.white60, fontSize: 14)),
                  ),
                ],
              ),
            ],
          );
        }
        return Container();
      });
}
