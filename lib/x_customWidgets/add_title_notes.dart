import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'alert_dialogue.dart';

void addTitleNotes(BuildContext context,
    {required Future<void> Function(String title, String notes)? todo}) {
  Rx<String> name = "".obs;
  Rx<String> notes = "".obs;
  alertDialogW(context,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            LimitedBox(
              maxHeight: 80,
              child: TextField(
                maxLines: null,
                autofocus: true,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Food name',
                  isDense: true,
                ),
                onChanged: (value) {
                  name.value = value;
                },
              ),
            ),
            const SizedBox(height: 10),
            LimitedBox(
              maxHeight: 180,
              child: TextField(
                maxLines: null,
                autofocus: true,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  isDense: true,
                ),
                onChanged: (value) {
                  notes.value = value;
                },
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  onPressed: () async {
                    if (name.value.isNotEmpty || notes.value.isNotEmpty) {
                      if (todo != null) {
                        todo(name.value, notes.value);
                      }
                    }
                    Get.back();
                  },
                  child: const Text("Add")),
            ),
          ],
        ),
      ));
}
