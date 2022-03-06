import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class RecipiesNamesEdit extends StatelessWidget {
  const RecipiesNamesEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<Map<String, dynamic>>(
      shrinkWrap: true,
      query: FirebaseFirestore.instance
          .collection("FoodData")
          .where("isRecipie", isEqualTo: true)
          .orderBy("fID", descending: true),

      // .orderBy(gs.lastChatTime, descending: true),
      itemBuilder: (context, snapshot) {
        Map<String, dynamic> recipieMap = snapshot.data();
        String? commonName = recipieMap["names"]["Common_name"];
        String? fID = recipieMap["fID"];

        return ListTile(
          title: Text(commonName.toString()),
          trailing: Text(fID.toString()),
          onTap: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                TextEditingController tc = TextEditingController();
                tc.text = commonName.toString();
                return AlertDialog(
                    scrollable: true,
                    actionsAlignment: MainAxisAlignment.start,
                    content: SizedBox(
                      height: 200,
                      // width: 300,
                      child: Column(
                        children: [
                          TextField(
                            controller: tc,
                            autofocus: true,
                            maxLines: null,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          TextButton(
                            child: Text("Modify"),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await FirebaseFirestore.instance
                                  .collection("FoodData")
                                  .doc(fID)
                                  .update({"names.Common_name": tc.text});
                            },
                          )
                        ],
                      ),
                    ));
              },
            );
          },
        );
      },
    );
  }
}
