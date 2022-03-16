import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

AddFoodController adfc = AddFoodController();

class AddFoodController {
  Rx<String> searchString = "".obs;
  final foodsListMaps = RxList<Map<String, Map<String, dynamic>>>([]).obs;
  final Rx<String> webURL = "".obs;
  final Rx<String> webFoodName = "".obs;
  final listFoodIDs = RxList<String>([]).obs;
  final grossSelectedFCmodelMap = RxMap<String, Map<String, dynamic>>().obs;
  final netSelectedFCmodelMap = RxMap<String, FoodsCollectionModel>().obs;
  final grossSelectedCount = RxInt(0).obs;
  final ytSeachList = RxList().obs;
  final isItemAddedToList = false.obs;
  final addedFoodList = RxList<FoodsCollectionModel>([]).obs;
}
