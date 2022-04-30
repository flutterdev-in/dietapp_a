import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_food_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stamp_image/stamp_image.dart';

Future<void> camPicPhotoUploadFunction(
  BuildContext context,
  DocumentReference activeTimingDR,
) async {
  await imagePicker.pickImage(source: ImageSource.camera).then((photo) async {
    if (photo != null) {
      isLoading.value = true;
      final storageRef = FirebaseStorage.instance.ref();
      final String dateTimeString =
          "${admos.dayStringFromDate(dateNow)}_${atmos.timingFireStringFromDateTime(dateNow)}";
      final userSR =
          storageRef.child("users").child(userUID).child("$dateTimeString.jpg");
      try {
        await FlutterNativeImage.compressImage(io.File(photo.path).path,
                quality: 80, targetWidth: 300, targetHeight: 300)
            .then((file) async {
          StampImage.create(
              context: context,
              image: file,
              children: [
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: Text(
                    DateFormat("dd MMM yyyy (EEE) hh:mm a").format(dateNow),
                    textScaleFactor: 0.9,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ],
              onSuccess: (waterFile) async =>
                  await userSR.putFile(waterFile).then((ts) async {
                    await ts.ref.getDownloadURL().then((url) async {
                      ActiveFoodModel afm = ActiveFoodModel(
                          foodTypeCamPlanUp: afmos.cam,
                          isTaken: true,
                          foodAddedTime: dateNow,
                          takenTime: dateNow,
                          foodName: dateTimeString,
                          plannedNotes: null,
                          takenNotes: null,
                          prud: null,
                          trud: RefUrlMetadataModel(
                              url: "",
                              img: url,
                              title: dateTimeString,
                              isYoutubeVideo: false,
                              youtubeVideoLength: null),
                          docRef: null);

                      await activeTimingDR
                          .collection(afmos.foods)
                          .add(afm.toMap())
                          .then((value) => isLoading.value = false);
                    });
                  }));
        });
      } catch (e) {
        // ...
      }
    }
  });
}
