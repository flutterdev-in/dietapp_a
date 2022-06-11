import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:get/get.dart';

AddFoodController adfc = AddFoodController();

class AddFoodController {
  Rx<String> searchString = "".obs;
  final foodsListMaps = RxList<Map<String, Map<String, dynamic>>>([]).obs;
  final Rx<String> webURL = "".obs;
  final Rx<String> webFoodName = "".obs;
  final listFoodIDs = RxList<String>([]).obs;
  final grossSelectedFCmodelMap = RxMap<String, Map<String, dynamic>>().obs;
  final netSelectedFCmodelMap = RxMap<String, FoodModel>().obs;
  final grossSelectedCount = RxInt(0).obs;
  final ytSeachList = RxList().obs;
  final isItemAddedToList = false.obs;
  final addedFoodList = RxList<FoodModel>([]).obs;
}
