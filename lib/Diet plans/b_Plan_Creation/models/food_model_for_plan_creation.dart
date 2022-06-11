import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/y_Models/food_model.dart';

// class FoodModel {
//   DateTime foodAddedTime;
//   String foodName;
//   String? notes;
//   DocumentReference<Map<String, dynamic>>? docRef;
//   RefUrlMetadataModel? rumm;
//   FoodModel({
//     required this.foodAddedTime,
//     required this.foodName,
//     required this.notes,
//     required this.rumm,
//     this.docRef,
//   });

//   Map<String, dynamic> toMap() {
//     Map<String, dynamic> returnMap = {
//       fmfpcfos.foodAddedTime:
//           Timestamp.fromDate(foodAddedTime).millisecondsSinceEpoch,
//       fmfpcfos.foodName: foodName,
//       unIndexed: {}
//     };
//     Map<String, dynamic> nullChaeckValues = {
//       rummfos.rumm: rumm?.toMap(),
//       fmfpcfos.notes: notes,
//       fmfpcfos.docRef: docRef,
//     };

//     nullChaeckValues.forEach((key, value) {
//       if (value != null) {
//         returnMap[unIndexed][key] = value;
//       }
//     });

//     return returnMap;
//   }

//   factory FoodModel.fromMap(Map dataMap) {
//     return FoodModel(
//       foodAddedTime:
//           Timestamp.fromMillisecondsSinceEpoch(dataMap[fmfpcfos.foodAddedTime])
//               .toDate(),
//       foodName: dataMap[fmfpcfos.foodName] ?? "",
//       notes: dataMap[unIndexed][fmfpcfos.notes],
//       rumm: rummfos.rummFromRummMap(dataMap[unIndexed][rummfos.rumm]),
//       docRef: dataMap[unIndexed][fmfpcfos.docRef],
//     );
//   }
// }

final FoodsModelForPlanCreationFinalObjects fmfpcfos =
    FoodsModelForPlanCreationFinalObjects();

class FoodsModelForPlanCreationFinalObjects {
  final String foodAddedTime = "foodAddedTime";
  final String foodName = "foodName";
  final String imgURL = "imgURL";
  final String notes = "notes";
  final String refURL = "refURL";
  String docRef = docRef0;
  //
  final String foods = "foods";

 
}
