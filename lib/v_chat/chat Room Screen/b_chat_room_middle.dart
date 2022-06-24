import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/day_plan_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/diet_plans_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/multi_foods_collection_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/request_widget_dietchat.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/single_folder_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/text_widget_chat.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/timing_plan_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/web_food_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/week_plan_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/youtube_video_widget.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/v_chat/models/message_model.dart';
import 'package:dietapp_a/y_Models/day_model.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatRoomMiddle extends StatelessWidget {
  final ChatRoomModel crm;

  const ChatRoomMiddle(this.crm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
        ),
        child: FirestoreListView<Map<String, dynamic>>(
          pageSize: 5,
          reverse: true,
          shrinkWrap: true,
          query: crm.chatDR
              .collection(crs.chats)
              .orderBy(mmos.senderSentTime, descending: true),

          // .orderBy(gs.lastChatTime, descending: true),
          itemBuilder: (context, snapshot) {
            Map<String, dynamic> messageMap = snapshot.data();
            MessageModel mm = MessageModel.fromMap(messageMap);
            mm.docRef = snapshot.reference;
            bool isSentByMe = mm.chatSentBy != userUID;

            return InkWell(
              child: Column(
                children: [
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: chatWidget(mm),
                    ),
                    alignment: isSentByMe
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                      child: Row(
                        mainAxisAlignment: isSentByMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Text(chatTimeString(mm.senderSentTime),
                              textScaleFactor: 0.85),
                          const SizedBox(width: 2),
                          if (isSentByMe)
                            tickIcon(mm.senderSentTime, mm.recieverSeenTime,
                                mm.docRef)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onLongPress: () async {},
            );
          },
        ),
      ),
    );
  }
}

Widget chatWidget(MessageModel mm) {
  List? listDocMaps = mm.listDocMaps;

  if (mm.chatType == chatTS.singleYoutube) {
    Map<String, dynamic> map = listDocMaps!.first as Map<String, dynamic>;
    FoodModel fdcm = FoodModel.fromMap(map);
    return YoutubeVideoWidget(fdcm: fdcm, text: mm.chatString);
  } else if (mm.chatType == chatTS.singleWebFood) {
    Map<String, dynamic> map = listDocMaps!.first as Map<String, dynamic>;
    FoodModel fdcm = FoodModel.fromMap(map);
    return WebFoodMiddle(fdcm: fdcm, text: mm.chatString);
  } else if (mm.chatType == chatTS.singleFolder) {
    Map<String, dynamic> map = listDocMaps!.first as Map<String, dynamic>;
    FoodModel fdcm = FoodModel.fromMap(map);
    return SingleFolderMiddle(fdcm: fdcm, text: mm.chatString);
  } else if (mm.chatType == chatTS.multiFoodCollection) {
    return MultiFoodsCollectionMiddle(
        listFDCM: listDocMaps!.map((e) {
          Map<String, dynamic> map = e as Map<String, dynamic>;
          return FoodModel.fromMap(map);
        }).toList(),
        text: mm.chatString);
  } else if (mm.chatType == chatTS.multiDay) {
    return DayPlanMiddle(
        listDays: listDocMaps!.map((e) {
          Map<String, dynamic> map = e as Map<String, dynamic>;
          return DayModel.fromMap(map);
        }).toList(),
        text: mm.chatString);
  } else if (mm.chatType == chatTS.multiWeek) {
    return WeekPlanMiddle(
        listModels: listDocMaps!.map((e) {
          Map<String, dynamic> map = e as Map<String, dynamic>;
          return WeekModel.fromMap(map);
        }).toList(),
        text: mm.chatString);
  } else if (mm.chatType == chatTS.multiTiming) {
    return TimingPlanMiddle(
        listModels: listDocMaps!.map((e) {
          Map<String, dynamic> map = e as Map<String, dynamic>;
          return TimingModel.fromMap(map);
        }).toList(),
        text: mm.chatString);
  } else if (mm.chatType == chatTS.multiPlan) {
    return DietPlansMiddle(
        listModels: listDocMaps!.map((e) {
          Map<String, dynamic> map = e as Map<String, dynamic>;
          return DietPlanBasicInfoModel.fromMap(map);
        }).toList(),
        text: mm.chatString);
  } else if (mm.chatType == chatTS.viewRequest) {
    return RequestWidgetDietChat(mm);
  } else {
    return TextWidgetChatMiddle(mm: mm);
  }
}

//


String chatTimeString(DateTime senderSentTime) {
  String ampm = DateFormat("a").format(senderSentTime).toLowerCase();
  String chatDayTime = DateFormat("dd MMM h:mm ").format(senderSentTime) + ampm;
  //
  String today = DateFormat("dd MMM").format(DateTime.now());
  String chatDay = DateFormat("dd MMM").format(senderSentTime);

  if (today == chatDay) {
    chatDayTime = DateFormat("h:mm ").format(senderSentTime) + ampm;
  }

  return chatDayTime;
}

Icon tickIcon(
  DateTime? senderSentTime,
  DateTime? recieverSeenTime,
  DocumentReference? docRef,
) {
  if (recieverSeenTime != null) {
    return const Icon(
      MdiIcons.checkAll,
      color: Colors.blue,
      size: 18,
    );
  } else if (docRef != null) {
    return const Icon(
      MdiIcons.check,
      color: Colors.black,
      size: 18,
    );
  } else {
    return const Icon(
      MdiIcons.cached,
      color: Colors.black,
      size: 18,
    );
  }
}


