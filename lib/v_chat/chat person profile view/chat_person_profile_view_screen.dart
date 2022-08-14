import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/x_customWidgets/expandable_text.dart';
import 'package:dietapp_a/x_customWidgets/lootie_animations.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ChatPersonProfileViewScreen extends StatelessWidget {
  final ChatRoomModel crm;
  const ChatPersonProfileViewScreen(
    this.crm, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: usersCollection.doc(crm.chatPersonUID).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loot.linerDotsLoading();
            }
            if (snapshot.hasData && snapshot.data!.data() != null) {
              var uwm = UserWelcomeModel.fromMap(snapshot.data!.data()!);
              return profile(uwm);
            }
            return Container();
          }),
    );
  }

  Widget profile(UserWelcomeModel uwm) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            if (uwm.photoURL != null)
              Center(
                child: CircleAvatar(
                    radius: 70,
                    child: ClipOval(
                        child: CachedNetworkImage(
                      imageUrl: uwm.photoURL!,
                      fit: BoxFit.cover,
                      width: 140,
                      height: 140,
                    ))),
              ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text("Profile Name  :  " + uwm.displayName,
                  textScaleFactor: 1.1),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text("User ID  :  @" + uwm.userID),
            ),
            const SizedBox(height: 20),
            if (uwm.bioData.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: expText("Bio  :  " + uwm.bioData,
                    textColor: Colors.black, maxLines: 3)!,
              ),
            if (crm.chatPersonUID != userUID) ChatPersonPermissionsView(crm),
          ],
        ),
      ),
    );
  }
}

class ChatPersonPermissionsView extends StatelessWidget {
  final ChatRoomModel crmOld;
  const ChatPersonPermissionsView(this.crmOld, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: crmOld.chatDR.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.data() != null) {
            var crm = ChatRoomModel.fromMap(snapshot.data!.data()!);
            return Column(
              children: [
                ListTile(
                  title: const Text("Diet view"),
                  trailing: GFToggle(
                    type: GFToggleType.ios,
                    enabledTrackColor: primaryColor,
                    enabledText: "on",
                    disabledText: "off",
                    value: crm.userModel.isDietAllowed,
                    onChanged: (value) async {
                      if (value != null) {
                        await crmOld.chatDR.update({
                          "$unIndexed.$userUID.${crs.isDietAllowed}": value,
                        });
                      }
                    },
                  ),
                ),
                // ListTile(
                //   title: const Text("Chat permisson"),
                //   trailing: GFToggle(
                //     type: GFToggleType.ios,
                //     enabledTrackColor: primaryColor,
                //     enabledText: "on",
                //     disabledText: "off",
                //     value: crm.userModel.isChatAllowed,
                //     onChanged: (value) async {
                //       if (value != null) {
                //         await crmOld.chatDR.update({
                //           "$unIndexed.$userUID.${crs.isChatAllowed}": value,
                //         });
                //       }
                //     },
                //   ),
                // ),
              ],
            );
          }
          return const SizedBox();
        });
  }
}
