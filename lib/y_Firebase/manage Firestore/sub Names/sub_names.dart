import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Rx<String> beforeName0 = "beforeName".obs;

class SubSearchNamesN extends StatelessWidget {
  const SubSearchNamesN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
            child: Obx(() => Column(
                  children: [
                    Text(beforeName0.value),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                )),
          ),
          ElevatedButton(
            child: const Text("Start modification"),
            onPressed: () async {
              await ninUpdate();
            },
          ),
        ],
      ),
    );
  }
}

Future<void> ninUpdate() async {
  // WriteBatch batch = FirebaseFirestore.instance.batch();

  await FirebaseFirestore.instance
      .collection('FoodData')
      .where("isIng", isEqualTo: true)
      .get()
      .then((querySnapshot) async {
    for (var document in querySnapshot.docs) {
      Map docMap = document.data();
      Map<String, String>? names = docMap["names"];
      List<String>? listSearchStrings = docMap["searchFields"];
      if (names != null && listSearchStrings != null) {
        List<String> listSubNames = names.values.toSet().toList();
        await document.reference.update({
          "listSubNames": listSubNames,
          "listSearchStrings": listSearchStrings
        });
        beforeName0.value = document.id;
      }
    }
  });
}
