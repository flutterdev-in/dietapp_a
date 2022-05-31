import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_food_model.dart';

DeleteActiveEntries deleteActiveEntries = DeleteActiveEntries();

class DeleteActiveEntries {
  Future<void> deleteActiveTiming(DocumentReference activeTimingDR) async {
    await activeTimingDR.collection(afmos.foods).get().then((foodsQS) async {
      if (foodsQS.docs.isNotEmpty) {
        for (var foodDS in foodsQS.docs) {
          await foodDS.reference.delete();
        }
      }
    });

    await activeTimingDR.delete();
  }
}
