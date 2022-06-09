import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:dietapp_a/v_chat/models/message_model%20copy.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RequestWidgetDietChat extends StatelessWidget {
  final MessageModel mm;
  const RequestWidgetDietChat(this.mm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonTopWidgetMiddle(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: mm.docRef!.snapshots(),
            builder: (context, snapshot) {
              DietChatRequestModel? dcrm;
              if (snapshot.hasData && snapshot.data!.data() != null) {
                var mmNew = MessageModel.fromMap(snapshot.data!.data()!);
                if (mmNew.listDocMaps != null &&
                    mmNew.listDocMaps!.isNotEmpty) {
                  dcrm = DietChatRequestModel.fromMap(mmNew.listDocMaps!.first);
                }
              }
              if (dcrm != null) {
                if (mm.chatSentBy == userUID) {
                  return Container(
                    width: double.maxFinite,
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Column(
                        children: [
                          Text(
                              "${dcrm.isDietViewRequest ? 'Diet' : 'Chat'} view request sent"),
                          const SizedBox(height: 10),
                          dcrm.isApproved == null
                              ? const Text("Status : 'Pending..'")
                              : dcrm.isApproved!
                                  ? const Text("Status : 'Approved'")
                                  : const Text("Status : 'Rejected'"),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    width: double.maxFinite,
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Column(
                        children: [
                          Text(
                              "${dcrm.isDietViewRequest ? 'Diet' : 'Chat'} view requested"),
                          dcrm.isApproved == null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GFButton(
                                        child: const Text('Reject'),
                                        color: Colors.red,
                                        onPressed: () {}),
                                    GFButton(
                                        child: const Text('Approve'),
                                        color: Colors.green,
                                        onPressed: () {}),
                                  ],
                                )
                              : dcrm.isApproved!
                                  ? GFButton(
                                      color: Colors.green.shade500,
                                      child: SizedBox(
                                        width: 110,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(MdiIcons.checkDecagram),
                                            Text(" Approved"),
                                          ],
                                        ),
                                      ),
                                      onPressed: () {})
                                  : GFButton(
                                      color: Colors.red,
                                      child: SizedBox(
                                        width: 110,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: const [
                                                Icon(MdiIcons.closeCircle),
                                                Text(" Rejected"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      onPressed: () {})
                        ],
                      ),
                    ),
                  );
                }
              } else {
                return const SizedBox();
              }
            }),
        text: null);
  }
}
