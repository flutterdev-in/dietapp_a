import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:flutter/material.dart';

class SingleChatFromStreamWidget extends StatelessWidget {
  final String docPath;

  const SingleChatFromStreamWidget({Key? key, required this.docPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.doc(docPath).snapshots(),
        builder: (context, docSnap) {
          String parent = FirebaseFirestore.instance.doc(docPath).parent.id;
          if (docSnap.hasData && docSnap.data != null) {}
          return  SizedBox();
        });
  }
}
