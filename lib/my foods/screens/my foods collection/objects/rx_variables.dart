import 'package:get/get.dart';

RxFoodsCollectionVariables rxfcv = RxFoodsCollectionVariables();

class RxFoodsCollectionVariables {
  Rx<String> currentFoodsCollectionDocID = ''.obs;
  Rx<bool> isDeletePressed = false.obs;
  Rx<bool> isSortPressed = false.obs;
  RxMap mapCollectionIDs = {}.obs;
}
