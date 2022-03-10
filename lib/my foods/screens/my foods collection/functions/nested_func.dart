import 'package:cloud_firestore/cloud_firestore.dart';

class BatchCopyNestedCollections {
  //Combined function
  Future<void> batchCopy({
    required List<DocumentReference> listSourceDR,
    required DocumentReference targetDR,
  }) async {
    for (DocumentReference sourceDR in listSourceDR) {
      await batchCopyNestedFunction(sourceDR: sourceDR, targetDR: targetDR);
    }
  }

  //
  Future<void> batchCopyNestedFunction({
    required DocumentReference sourceDR,
    required DocumentReference targetDR,
  }) async {
    await sourceDR.collection("subCollection").get().then(
      (querySnapshot) async {
        for (QueryDocumentSnapshot<Map<String, dynamic>> document
            in querySnapshot.docs) {
          DocumentReference nestedSourceCR = document.reference;
          String thisDocID = document.id;
          DocumentReference nestedTargetDR =
              targetDR.collection("subCollection").doc(thisDocID);
          await nestedTargetDR.set(
            document.data(),
            SetOptions(merge: true),
          );

          await batchCopyNestedFunction(
              sourceDR: nestedSourceCR, targetDR: nestedTargetDR);
        }
      },
    );
  }
}
