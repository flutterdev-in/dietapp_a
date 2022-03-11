import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';

Future<void> batchDeleteFunction(List<DocumentReference> listSourceDR) async {
  fcc.documentsFetchedForBatch.value = 0;
  fcc.documentsDeletedFromBatch.value = 0;
  List<DocumentReference> listAllNestedDRs = [];
  Future<void> nestedGetFunction(List<DocumentReference> listSourceDR) async {
    for (DocumentReference sourceDR in listSourceDR) {
      listAllNestedDRs.add(sourceDR);
      fcc.documentsFetchedForBatch.value++;
      //
      await sourceDR.collection(fdcs.subCollections).limit(50).get().then(
        (docQuerySnap) async {
          List<DocumentReference> listAllNestedDRs0 = [];
          for (QueryDocumentSnapshot<Map<String, dynamic>> doc
              in docQuerySnap.docs) {
            listAllNestedDRs0.add(doc.reference);
          }
          await nestedGetFunction(listAllNestedDRs0);
        },
      );
    }
  }

  await nestedGetFunction(listSourceDR);
  listAllNestedDRs.reversed;
  for (DocumentReference eachDR in listAllNestedDRs) {
    print(eachDR.path);
    print(fcc.currentPathCR.value);
    // eachDR.delete();
    fcc.documentsDeletedFromBatch.value++;
  }
}
