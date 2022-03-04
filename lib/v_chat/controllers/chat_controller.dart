import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:get/get.dart';

ChatController cc = Get.put(ChatController());

class ChatController extends GetxController {
  Rx<String> thisChatDocID = "${userUID}_$userUID".obs;
  Rx<String> thisChatPersonUID = userUID.obs;
}
