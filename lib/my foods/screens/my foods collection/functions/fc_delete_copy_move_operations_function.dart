import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';

Future<void> fcDeleteCopyMoveOperations({
  required List<DocumentReference> listSourceDR,
  required String? targetCRpath,
}) async {
  print("object");
  fcc.documentsFetchedForBatch.value = 0;
  fcc.documentsDeletedFromBatch.value = 0;
  Map<String, dynamic> mapsInfoOfNestedDRs = {};
  Future<void> nestedGetFunction(List<DocumentReference> listSourceDR) async {
    for (DocumentReference sourceDR in listSourceDR) {
      sourceDR.get().then((DocumentSnapshot ds) {
        mapsInfoOfNestedDRs.addAll({
          sourceDR.path: ds.data(),
        });
        fcc.printPurpose.value = ds.data().toString();
      });

      fcc.documentsFetchedForBatch.value++;

      //
      await sourceDR.collection(fdcs.subCollections).get().then(
        (docQuerySnap) async {
          List<DocumentReference> listAllNestedDRs0 = [];
          for (QueryDocumentSnapshot<Map<String, dynamic>> doc
              in docQuerySnap.docs) {
            listAllNestedDRs0.add(doc.reference);
            mapsInfoOfNestedDRs.addAll({
              doc.reference.path: doc.data(),
            });
          }
          await nestedGetFunction(listAllNestedDRs0);
        },
      );
    }
  }

  await nestedGetFunction(listSourceDR);

  CollectionReference fdcPath = FirebaseFirestore.instance
      .collection(uss.users)
      .doc(userUID)
      .collection(fdcs.foodsCollection);

  mapsInfoOfNestedDRs.forEach(
    (sourceDocPath, sourceDocMap) async {
      if (fcc.operationValue.value == 0) {
        fcc.printPurpose.value = sourceDocPath;
        await FirebaseFirestore.instance.doc(sourceDocPath).delete();
      } else if (sourceDocMap is Map<String, dynamic> && targetCRpath != null) {
        String thisDocPath =
            sourceDocPath.replaceAll(fdcPath.path, targetCRpath);
        if (fcc.operationValue.value == 1) {
          await FirebaseFirestore.instance
              .doc(thisDocPath)
              .set(sourceDocMap, SetOptions(merge: true));
        } else if (fcc.operationValue.value == 2) {
          fcc.printPurpose.value = targetCRpath + "++" + thisDocPath;
          await FirebaseFirestore.instance.doc(sourceDocPath).delete();
          await FirebaseFirestore.instance
              .doc(thisDocPath)
              .set(sourceDocMap, SetOptions(merge: true));
        }
      }
    },
  );
}
