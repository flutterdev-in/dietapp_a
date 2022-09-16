import 'package:cloud_firestore/cloud_firestore.dart';
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
          if (docSnap.hasData && docSnap.data != null) {}
          return const SizedBox();
        });
  }
}
