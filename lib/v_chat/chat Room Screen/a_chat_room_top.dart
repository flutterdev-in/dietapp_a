import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/v_chat/chat%20person%20profile%20view/chat_person_profile_view_screen.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/x_customWidgets/stream_builder_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Rx<bool> isChatPersonOnChat = false.obs;

class ChatRoomAppBar extends StatelessWidget {
  final ChatRoomModel crm;
  const ChatRoomAppBar(this.crm, {Key? key}) : super(key: key);

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
        details(crm),
      ],
    );
  }

  Widget ifChatOpen(UserWelcomeModel uwm, {required Widget elseW}) {
    return StreamBuilder(
        stream: crm.chatDR.snapshots(),
        builder: (c, AsyncSnapshot<DocumentSnapshot> d) {
          var data = docStreamReturn(c, d, widType: "tile");
          var isChatPersonOnChat = false;
          if (data is Map) {
            Map d = data as Map<String, dynamic>;
            var crmNew = ChatRoomModel.fromMap(data);

            if (crmNew.chatPersonModel.isThisChatOpen) {
              isChatPersonOnChat = true;
            }
          }
          return (isChatPersonOnChat && uwm.isActive)
              ? const Text(
                  "on chat",
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                )
              : elseW;
        });
  }

  Widget details(ChatRoomModel crm) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(uwmos.users)
            .doc(crm.chatPersonUID)
            .snapshots(),
        builder: (c, AsyncSnapshot<DocumentSnapshot> d) {
          var data = docStreamReturn(c, d, widType: "tile");
          if (data is Map) {
            UserWelcomeModel uwm = UserWelcomeModel.fromMap(data);

            return InkWell(
              child: Row(
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      ifChatOpen(
                        uwm,
                        elseW: Text(uwm.isActive ? "online" : "inactive",
                            style: const TextStyle(
                                color: Colors.white60, fontSize: 14)),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                Get.to(() => ChatPersonProfileViewScreen(
                    chatPersonUID: crm.chatPersonUID));
              },
            );
          }
          return Container();
        });
  }
}
