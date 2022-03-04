
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:get/get.dart';

Rx<bool> isChatPersonOnChat = false.obs;

Rx<String> chatPersonUID = userUID.obs;
Rx<String> thisChatDocID = "${userUID}_$userUID".obs;
