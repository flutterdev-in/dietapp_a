import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/a_colllecton_view_navbar.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/functions/chat_room_functions.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/functions/chat_room_send_functions.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/nav%20bar/b_plan_view_for_chat.dart';
import 'package:dietapp_a/v_chat/controllers/chat_room_controller.dart';
import 'package:dietapp_a/v_chat/controllers/chat_room_variables.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';
import 'package:dietapp_a/x_FCM/fcm_model.dart';
import 'package:dietapp_a/x_customWidgets/bottom_sheet_widget.dart';
import 'package:dietapp_a/y_Models/day_model.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatRoomBottom extends StatelessWidget {
  final bool isSuffixButtonsRequired;
  final ChatRoomModel crm;

  const ChatRoomBottom(
    this.crm, {
    Key? key,
    this.isSuffixButtonsRequired = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController tc = TextEditingController();
    // final ChatScreenController chatSC = ChatScreenController(crm);

    return Container(
      color: Colors.teal.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 4 / 5 - 10,
                maxHeight: 120,
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Obx(() => TextField(
                      // focusNode: csv.focusNode,
                      maxLines: null,
                      keyboardType: isSuffixButtonsRequired
                          ? TextInputType.multiline
                          : TextInputType.name,
                      controller: tc,
                      decoration: InputDecoration(
                        suffixIcon: (csv.tcText.value.isEmpty &&
                                isSuffixButtonsRequired)
                            ? suffixIconW(context)
                            : null,
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Message...',
                        contentPadding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                      ),
                      onChanged: (value) {
                        csv.tcText.value = value;
                      },
                    )),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GFAvatar(
                backgroundColor: primaryColor,
                size: GFSize.SMALL,
                child: IconButton(
                  color: Colors.white,
                  icon: const Icon(MdiIcons.send),
                  onPressed: () async {
                    String tcText = csv.tcText.value;
                    tc.clear();
                    csv.tcText.value = "";

                    List<Map<String, dynamic>>? listDocMaps;
                    String chatType = chatTS.stringOnly;

                    var clfn = getFinalListAndName(crm);

                    if ((tcText.trim().isNotEmpty) ||
                        csv.selectedList.value.isNotEmpty) {
                      listDocMaps = clfn.listDocs;
                      chatType = csv.chatType.value;
                      //
                      FcmModel fcmModel =
                          await ChatRoomFunctions.getFcmModel(crm);
                      fcmModel.chatImg = clfn.chatImage;
                      fcmModel.fcmBody = fcmos.getFcmBody(
                          chatType: chatType,
                          chatString: tcText,
                          fileName: clfn.fileName);

                      await crm.chatDR
                          .collection(crs.chats)
                          .add(
                            MessageModel(
                              chatSentBy: userUID,
                              chatRecdBy: crm.chatPersonUID,
                              chatString: tcText,
                              senderSentTime: DateTime.now(),
                              listDocMaps: listDocMaps,
                              chatType: chatType,
                              fcmModel: fcmModel,
                            ).toMap(),
                          )
                          .then((docRf) async {
                        if (chatType != chatTS.stringOnly) {
                          Navigator.pop(context);
                        }

                        await docRf.update(
                          {
                            mmos.senderSentTime:
                                Timestamp.fromDate(DateTime.now()),
                            mmos.recieverSeenTime: fcmModel.isRecieverOnChat
                                ? Timestamp.fromDate(DateTime.now())
                                : null,
                            "$unIndexed.$docRef0": docRf
                          },
                        );

                        ChatRoomSendFunctions().updateChatDocAfterSend(
                            chatRoomDR: crm.chatDR,
                            lastChatDR: docRf,
                            lastChatSentBy: userUID,
                            lastChatRecdBy: crm.chatPersonUID);
                      });

                      csv.chatType.value = chatTS.stringOnly;
                      csv.selectedList.value.clear();
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget suffixIconW(BuildContext context) {
    return SizedBox(
      width: 125,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(MdiIcons.folderTextOutline),
            ),
            highlightColor: Colors.purple,
            splashColor: Colors.purple,
            onTap: () {
              csv.chatType.value = chatTS.collectionView;

              bottomSheetW(
                context,
                CollectionViewNavBar(crm),
              );
            },
          ),
          InkWell(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(MdiIcons.clipboardTextOutline),
            ),
            highlightColor: Colors.purple,
            splashColor: Colors.purple,
            onTap: () {
              csv.chatType.value = chatTS.planView;

              bottomSheetW(
                context,
                PlanViewForChat(crm, ChatScreenController(crm)),
              );
            },
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  // List<Map<String, dynamic>> getFinalList(ChatRoomModel crm) {

  //   final List<QueryDocumentSnapshot<Map<String, dynamic>>> selectedList =
  //       csv.selectedList.value;
  //   List<Map<String, dynamic>> finalList = selectedList.map((snapshot) {
  //     Map<String, dynamic> map = snapshot.data();

  //     map[unIndexed][docRef0] = snapshot.reference;
  //     return map;
  //   }).toList();

  //   bool isSingle = selectedList.length == 1;

  //   String parent = selectedList.first.reference.parent.id;

  //   QueryDocumentSnapshot<Map<String, dynamic>> snapshot = selectedList.first;
  //   if (selectedList.first.reference.path.contains(chatTS.foodsCollection)) {
  //     FoodModel fdcm = FoodModel.fromMap(snapshot.data());
  //     if (isSingle) {
  //       if (fdcm.isFolder == true && fdcm.rumm != null) {
  //         csv.chatType.value = chatTS.singleWebFolder;
  //       } else if (fdcm.isFolder == true) {
  //         csv.chatType.value = chatTS.singleFolder;
  //       } else if (fdcm.rumm?.isYoutubeVideo ?? false) {
  //         csv.chatType.value = chatTS.singleYoutube;
  //       } else if (fdcm.rumm != null) {
  //         csv.chatType.value = chatTS.singleWebFood;
  //       } else {
  //         csv.chatType.value = chatTS.singleCustomFood;
  //       }
  //     } else {
  //       csv.chatType.value = chatTS.multiFoodCollection;
  //     }
  //   } else if (selectedList.first.reference.path
  //       .contains(chatTS.dietPlansBeta)) {
  //     if (parent == dietpbims.dietPlansBeta) {
  //       csv.chatType.value = chatTS.multiPlan;
  //     } else if (parent == wmfos.weeks) {
  //       csv.chatType.value = chatTS.multiWeek;
  //     } else if (parent == dmos.days) {
  //       csv.chatType.value = chatTS.multiDay;
  //     } else if (parent == tmos.timings) {
  //       csv.chatType.value = chatTS.multiTiming;
  //     } else if (parent == fmos.foods) {
  //       // finalList = finalList
  //       //     .map((e) =>
  //       //         foodCollectionModelFromPlan(FoodModel.fromMap(e)).toMap())
  //       //     .toList();
  //       if (isSingle) {
  //         FoodModel fmp = FoodModel.fromMap(snapshot.data());
  //         if (fmp.rumm?.isYoutubeVideo ?? false) {
  //           csv.chatType.value = chatTS.singleYoutube;
  //         } else if (fmp.rumm != null) {
  //           csv.chatType.value = chatTS.singleWebFood;
  //         } else {
  //           csv.chatType.value = chatTS.singleCustomFood;
  //         }
  //       } else {
  //         csv.chatType.value = chatTS.multiFoodCollection;
  //       }
  //     }
  //   }

  //   return finalList;
  // }

  ChatListDocsFileName getFinalListAndName(ChatRoomModel crm) {
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> selectedList =
        csv.selectedList.value;
    ChatListDocsFileName clfn =
        ChatListDocsFileName(listDocs: [], fileName: null, chatImage: null);

    List<Map<String, dynamic>>? finalList;
    if (selectedList.isNotEmpty) {
      finalList = selectedList.map((snapshot) {
        Map<String, dynamic> map = snapshot.data();

        map[unIndexed][docRef0] = snapshot.reference;
        return map;
      }).toList();
      clfn.listDocs = finalList;

      bool isSingle = selectedList.length == 1;

      String parent = selectedList.first.reference.parent.id;

      QueryDocumentSnapshot<Map<String, dynamic>> snapshot = selectedList.first;
      if (selectedList.first.reference.path.contains(chatTS.foodsCollection)) {
        FoodModel fdcm = FoodModel.fromMap(snapshot.data());
        clfn.fileName = fdcm.foodName;
        clfn.chatImage = fdcm.rumm?.img;
        if (isSingle) {
          if (fdcm.isFolder == true && fdcm.rumm != null) {
            csv.chatType.value = chatTS.singleWebFolder;
          } else if (fdcm.isFolder == true) {
            csv.chatType.value = chatTS.singleFolder;
          } else if (fdcm.rumm?.isYoutubeVideo ?? false) {
            csv.chatType.value = chatTS.singleYoutube;
          } else if (fdcm.rumm != null) {
            csv.chatType.value = chatTS.singleWebFood;
          } else {
            csv.chatType.value = chatTS.singleCustomFood;
          }
        } else {
          csv.chatType.value = chatTS.multiFoodCollection;
        }
      } else if (selectedList.first.reference.path
          .contains(chatTS.dietPlansBeta)) {
        if (parent == dietpbims.dietPlansBeta) {
          csv.chatType.value = chatTS.multiPlan;
        } else if (parent == wmfos.weeks) {
          csv.chatType.value = chatTS.multiWeek;
        } else if (parent == dmos.days) {
          csv.chatType.value = chatTS.multiDay;
        } else if (parent == tmos.timings) {
          csv.chatType.value = chatTS.multiTiming;
        } else if (parent == fmos.foods) {
          // finalList = finalList
          //     .map((e) =>
          //         foodCollectionModelFromPlan(FoodModel.fromMap(e)).toMap())
          //     .toList();
          if (isSingle) {
            FoodModel fmp = FoodModel.fromMap(snapshot.data());

            clfn.fileName = fmp.foodName;
            clfn.chatImage = fmp.rumm?.img;
            if (fmp.rumm?.isYoutubeVideo ?? false) {
              csv.chatType.value = chatTS.singleYoutube;
            } else if (fmp.rumm != null) {
              csv.chatType.value = chatTS.singleWebFood;
            } else {
              csv.chatType.value = chatTS.singleCustomFood;
            }
          } else {
            csv.chatType.value = chatTS.multiFoodCollection;
          }
        }

        if (selectedList.length == 1) {
          var map = selectedList.first.data();
          if (parent == dietpbims.dietPlansBeta) {
            var dpm = DietPlanBasicInfoModel.fromMap(map);
            clfn.fileName = dpm.planName;
            clfn.chatImage = dpm.rumm?.img;
          } else if (parent == wmfos.weeks) {
            var wm = WeekModel.fromMap(map);

            clfn.fileName = wm.weekName;
          } else if (parent == dmos.days) {
            var dm = DayModel.fromMap(map);
            clfn.fileName = dm.dayName;
            clfn.chatImage = dm.rumm?.img;
          } else if (parent == tmos.timings) {
            var tm = TimingModel.fromMap(map);
            clfn.fileName = tm.timingName;
            clfn.chatImage = tm.rumm?.img;
          }
        }
      }
    }

    return clfn;
  }
}

class ChatListDocsFileName {
  List<Map<String, dynamic>> listDocs;
  String? fileName;
  String? chatImage;

  ChatListDocsFileName({
    required this.listDocs,
    required this.fileName,
    required this.chatImage,
  });
}
