import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';

class RecipiesNamesModify extends StatelessWidget {
  const RecipiesNamesModify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<String> beforeName0 = "beforeName".obs;
    Rx<String> afterName0 = "afterName".obs;
    Rx<String> beforeName = "beforeName".obs;
    Rx<String> afterName = "afterName".obs;
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
            child: Obx(() => Column(
                  children: [
                    Text(beforeName0.value),
                    SizedBox(
                      height: 50,
                    ),
                    Text(afterName0.value),
                    Container(
                      height: 20,
                      color: Colors.black26,
                    ),
                    Text(beforeName.value),
                    SizedBox(
                      height: 50,
                    ),
                    Text(afterName.value),
                  ],
                )),
          ),
          ElevatedButton(
            child: Text("Start mofification"),
            onPressed: () async {
              int i = 996;

              // while (i > 963 && i < 965) {
              if (i == 996) {
                String docID = "RV$i";
                // i--;
                await FirebaseFirestore.instance
                    .collection("FoodData")
                    .doc(docID)
                    .get()
                    .then((docSnap) async {
                  if (docSnap.exists) {
                    Map<String, dynamic>? recipieMap = docSnap.data();
                    if (recipieMap != null) {
                      beforeName.value = recipieMap["names"]["Common_name"];
                      // await Future.delayed(Duration(seconds: 1));
                      afterName.value = beforeName.value
                          .replaceAll(RegExp(r"((^\s+)|(\s+$)|(\s{2,}))"), "")
                          .replaceAll(RegExp(r"\s{2,}"), " ");
                      await FirebaseFirestore.instance
                          .collection("FoodData")
                          .doc(docID)
                          .update({
                        "names.Common_name": afterName.value,
                      });
                      await Future.delayed(Duration(milliseconds: 600));
                      beforeName0.value = beforeName.value;
                      afterName0.value = afterName.value;
                      beforeName.value = "";
                      afterName.value = "";
                    }
                  }
                });
              }
              beforeName.value = "loop completed";
              afterName.value = "loop completed";
            },
          ),
        ],
      ),
    );
  }
}
