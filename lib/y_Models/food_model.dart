import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/x_customWidgets/web%20view/web_view_page.dart';
import 'package:dietapp_a/x_customWidgets/youtube/youtube_video_player.dart';
import 'package:get/get.dart';

class FoodModel {
  DateTime foodAddedTime;
  DateTime? foodTakenTime;
  String foodName;
  bool? isCamFood;
  bool? isFolder;
  String? notes;
  RefUrlMetadataModel? rumm;
  DocumentReference<Map<String, dynamic>>? docRef;

  FoodModel({
    required this.foodAddedTime,
    required this.foodTakenTime,
    required this.foodName,
    required this.isCamFood,
    required this.isFolder,
    required this.notes,
    required this.rumm,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      fmos.foodAddedTime:
          Timestamp.fromDate(foodAddedTime).millisecondsSinceEpoch,
      fmos.foodName: foodName,
      unIndexed: {}
    };
    Map<String, dynamic> nullChaeckValuesInd = {
      fmos.isFolder: isFolder,
      fmos.isCamFood: isCamFood,
      fmos.foodTakenTime:
          foodTakenTime != null ? Timestamp.fromDate(foodTakenTime!) : null,
    };

    nullChaeckValuesInd.forEach((key, value) {
      if (value != null) {
        returnMap[key] = value;
      }
    });
    Map<String, dynamic> nullChaeckValues = {
      rummfos.rumm: rumm?.toMap(),
      notes0: notes,
      docRef0: docRef,
    };

    nullChaeckValues.forEach((key, value) {
      if (value != null) {
        returnMap[unIndexed][key] = value;
      }
    });

    return returnMap;
  }

  factory FoodModel.fromMap(Map dataMap) {
    return FoodModel(
      foodAddedTime: (dataMap[fmos.foodAddedTime] != null)
          ? DateTime.fromMillisecondsSinceEpoch(dataMap[fmos.foodAddedTime])
          : DateTime.now(),
      foodTakenTime: dataMap[fmos.foodTakenTime]?.toDate(),
      isFolder: dataMap[fmos.isFolder],
      isCamFood: dataMap[fmos.isCamFood],
      foodName: dataMap[fmos.foodName] ?? "",
      notes: dataMap[unIndexed][notes0],
      rumm: rummfos.rummFromRummMap(dataMap[unIndexed][rummfos.rumm]),
      docRef: dataMap[unIndexed][docRef0],
    );
  }
}

final FoodsModelObjects fmos = FoodsModelObjects();

class FoodsModelObjects {
  final foodAddedTime = "foodAddedTime";
  final foodTakenTime = "foodTakenTime";
  final foodName = "foodName";
  final isCamFood = "isCamFood";
  final isFolder = "isFolder";
  //
  final foods = "foods";
  final foodsCollection = "foodsCollection";
  final subCollections = "subCollections";

  void onTapFoodTile(FoodModel fm) {
    if (fm.rumm?.isYoutubeVideo ?? false) {
      Get.to(() => YoutubeVideoPlayerScreen(fm.rumm!, fm.foodName));
    } else if (fm.rumm?.url != null && fm.isCamFood !=true && fm.isFolder !=true) {
      Get.to(WebViewPage(fm.rumm!.url, fm.foodName));
    }
  }
}
