import 'package:dietapp_a/userData/uid.dart';
import 'package:get/get.dart';

ChatController cc = Get.put(ChatController());

class ChatController extends GetxController {
  Rx<String> thisChatDocID = "${uid}_$uid".obs;
  Rx<String> thisChatPersonUID = uid.obs;
}
