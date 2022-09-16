
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';

BatchCopyNestedCollections batchCopyNestedCollections =
    BatchCopyNestedCollections();

class BatchCopyNestedCollections {
  //Combined function
  Future<void> batchCopy({
    required List<DocumentReference> listSourceDR,
    required String targetSubCRstring,
  }) async {
    for (DocumentReference sourceDR in listSourceDR) {
      sourceDR.get().then((value) async {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        await FirebaseFirestore.instance
            .collection(targetSubCRstring)
            .doc(sourceDR.id)
            .set(
              data,
              SetOptions(merge: true),
            )
            .then((value) async {
          String thistargetSubCRstring = FirebaseFirestore.instance
              .collection(targetSubCRstring)
              .doc(sourceDR.id)
              .collection(fdcs.subCollections)
              .path;
          await batchCopyNestedFunction(
              sourceDR: sourceDR, targetSubCRstring: thistargetSubCRstring);
        });
      });
    }
  }

  //
  Future<void> batchCopyNestedFunction({
    required DocumentReference sourceDR,
    required String targetSubCRstring,
  }) async {
    await sourceDR.collection(fdcs.subCollections).get().then(
      (querySnapshot) async {
        for (QueryDocumentSnapshot<Map<String, dynamic>> document
            in querySnapshot.docs) {
          DocumentReference nestedSourceCR = document.reference;
          DocumentReference thisDR = FirebaseFirestore.instance
              .collection(targetSubCRstring)
              .doc(document.id);
          String nestedTargetCRstring =
              thisDR.collection(fdcs.subCollections).path;
          await thisDR.set(
            document.data(),
            SetOptions(merge: true),
          );

          await batchCopyNestedFunction(
              sourceDR: nestedSourceCR,
              targetSubCRstring: nestedTargetCRstring);
        }
      },
    );
  }
}
