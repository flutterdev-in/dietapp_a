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
import 'package:image/image.dart' as Im;
import 'package:flutter_luban/flutter_luban.dart';

Future<void> camPicPhotoUploadFunction(
  BuildContext context,
  DocumentReference activeTimingDR,
) async {
  await imagePicker
      .pickImage(
    source: ImageSource.camera,
  )
      .then((photo) async {
    if (photo != null) {
      isLoading.value = true;
      CompressObject compressObject = CompressObject(
        imageFile: io.File(photo.path), //image
        path: photo.path, //compress to path
        quality: 85, //first compress quality, default 80
        step:
            9, //compress quality step, The bigger the fast, Smaller is more accurate, default 6
        mode: CompressMode.LARGE2SMALL, //default AUTO
      );
    await  Luban.compressImage(compressObject).then((compressedPath) async{
        final storageRef = FirebaseStorage.instance.ref();
      final String dateTimeString =
          "${admos.dayStringFromDate(dateNow)}_${atmos.timingFireStringFromDateTime(dateNow)}";
      final userSR =
          storageRef.child("users").child(userUID).child("$dateTimeString.jpg");
      try {
        StampImage.create(
            context: context,
            image: io.File(photo.path),
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
                  await Future.delayed(const Duration(seconds: 1));

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
                        .then((fmDR) async {
                      isLoading.value = false;

                      await Future.delayed(const Duration(seconds: 5))
                          .then((value) async {
                        final compressedImgRef = storageRef
                            .child("users")
                            .child(userUID)
                            .child("${dateTimeString}_800x800.jpg");

                        await compressedImgRef
                            .getDownloadURL()
                            .then((compressedURL) async {
                          fmDR.update({"unIndexed.trud.img": compressedURL});
                        });
                      });
                    });
                  });
                }));
      } catch (e) {
        // ...
      }
      });
      
      
    }
  });
}
