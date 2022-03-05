import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

Box cbox = Hive.box(crs.chatBox);

String userOwnChatDocID = "${userUID}_$userUID";

Rx<bool> isChatPersonOnChat = false.obs;
Rx<String> thisChatPersonUID = userOwnChatDocID.obs;
Rx<String> thisChatDocID = userUID.obs;

// String getCatPersonUID() {
//   return cbox.get(crs.thisChatPersonUID) ?? userUID;
// }

// void putChatPersonUID(String chatPersonUID) {
//   cbox.put(crs.thisChatPersonUID, chatPersonUID);
// }

// String getThisChatDocID() {
//   return cbox.get(crs.thisChatDocID) ?? "${userUID}_$userUID";
// }

// void putThisChatDocID(String thisChatDocID) {
//   cbox.put(crs.thisChatDocID, thisChatDocID);
// }
