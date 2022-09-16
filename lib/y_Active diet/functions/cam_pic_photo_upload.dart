import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:stamp_image/stamp_image.dart';

Future<void> camPicPhotoUploadFunction(
  BuildContext context,
  DocumentReference activeTimingDR,
) async {
  await imagePicker.pickImage(source: ImageSource.camera).then((photo) async {
    if (photo != null) {
      isLoading.value = true;
      await FlutterNativeImage.compressImage(
        photo.path,
        targetHeight: 800,
        targetWidth: 800,
      ).then((compressedFile) async {
        final storageRef = FirebaseStorage.instance.ref();
        final String dateTimeString =
            "${admos.activeDayStringFromDate(DateTime.now())}_${tmos.timingFireStringFromDateTime(DateTime.now())}";
        final userSR = storageRef
            .child("users")
            .child(userUID)
            .child("$dateTimeString.jpg");
        await userSR.putFile(compressedFile).then((ts) async {
          await Future.delayed(const Duration(seconds: 1));

          await ts.ref.getDownloadURL().then((url) async {
            FoodModel afm = FoodModel(
                isCamFood: true,
                foodAddedTime: DateTime.now(),
                foodTakenTime: DateTime.now(),
                isFolder: false,
                foodName: dateTimeString,
                notes: null,
                rumm: RefUrlMetadataModel(
                    url: "",
                    img: url,
                    title: dateTimeString,
                    isYoutubeVideo: false,
                    youtubeVideoLength: null),
                docRef: null);

            await activeTimingDR
                .collection(fmos.foods)
                .add(afm.toMap())
                .then((fmDR) async {});
          });
        });
      }).whenComplete(() {
        isLoading.value = false;
      });
    }
  });
}
