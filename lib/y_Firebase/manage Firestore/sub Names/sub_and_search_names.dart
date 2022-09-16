import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubSearchNames extends StatelessWidget {
  const SubSearchNames({Key? key}) : super(key: key);

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
                    const SizedBox(
                      height: 50,
                    ),
                    Text(afterName0.value),
                    Container(
                      height: 20,
                      color: Colors.black26,
                    ),
                    Text(beforeName.value),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(afterName.value),
                  ],
                )),
          ),
          ElevatedButton(
            child: const Text("Start modification"),
            onPressed: () async {
              int i = 1;

              while (i > 0 && i < 2000) {
                // if (i == 1) {

                String docID = "RV$i";
                beforeName.value = docID;
                await FirebaseFirestore.instance
                    .collection("FoodData")
                    .doc(docID)
                    .get()
                    .then((docSnap) async {
                  if (docSnap.exists) {
                    Map<String, dynamic>? recipieMap = docSnap.data();
                    if (recipieMap != null) {
                      await FirebaseFirestore.instance
                          .collection("FoodData")
                          .doc(docID)
                          .update(subSearchNames(recipieMap));
                    }
                  }
                });
                i++;
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

Map<String, dynamic> subSearchNames(Map<String, dynamic> recipieMap) {
  String commonName = recipieMap["names"]["Common_name"];
  //
  List<String> listSub0 = commonName.split("|").toList();
  List<String> listSub1 = [];
  for (var element in listSub0) {
    listSub1.add(element.trim().toLowerCase());
  }
  List<String> listSubNames = listSub1.toSet().toList();
  List<String> listSearchStrings = [recipieMap["fID"].toString().toLowerCase()];
  //
  for (String sn in listSubNames) {
    List<String> grossSNL = [sn];
    List<String> snL = sn.split(" ").toList();
    int i = 1;
    while (i < snL.length) {
      grossSNL.add(snL
          .sublist(i)
          .join(" ")
          .toLowerCase()
          .replaceAll(RegExp(r"[\(\)]"), "")
          .trim());
      i++;
    }
    for (String j in grossSNL) {
      int k = j.split("").toList().length;
      while (k > 0) {
        listSearchStrings.add(j.substring(0, k).toLowerCase());
        k--;
      }
    }
  }
  listSearchStrings = listSearchStrings.toSet().toList();

  return {"listSubNames": listSubNames, "listSearchStrings": listSearchStrings};
}
