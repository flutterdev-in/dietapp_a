import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/settings/user%20info%20screen/ax_profile_edit.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/x_customWidgets/stream_builder_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileFirst extends StatelessWidget {
  const ProfileFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(uss.users)
            .doc(userUID)
            .snapshots(),
        builder: (c, AsyncSnapshot<DocumentSnapshot> d) {
          var data = docStreamReturn(c, d, widType: "");
          if (data is Map) {
            UserWelcomeModel uwm = UserWelcomeModel.fromMap(data);

            return Container(
              // color: Colors.green,
              padding: const EdgeInsets.only(top: 15),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        InkWell(
                          child: CircleAvatar(
                            foregroundImage:
                                CachedNetworkImageProvider(uwm.photoURL!),
                            minRadius: 60,
                          ),
                          onTap: () {
                            Get.to(() => ProfileImageViewer(uwm.photoURL!));
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              uwm.displayName,
                              textScaleFactor: 1.4,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "@" + uwm.userID,
                              textScaleFactor: 1.2,
                            ),
                            // Text(userProfileMap["userID"]),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GFIconButton(
                        type: GFButtonType.transparent,
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Get.to(() => const ProfileEdit());
                        }),
                  ),
                ],
              ),
            );
          } else {
            return data;
          }
        });
  }
}

class ProfileImageViewer extends StatelessWidget {
  final String photoURL;

  const ProfileImageViewer(this.photoURL, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rxPhoto = photoURL.obs;
    var isLoading = false.obs;

    Future<void> pickPhoto(ImageSource source) async {
      await imagePicker.pickImage(source: source).then((photo) async {
        if (photo != null) {
          isLoading.value = true;
          await FlutterNativeImage.compressImage(
            photo.path,
          ).then((compressedFile) async {
            final storageRef = FirebaseStorage.instance.ref();

            final userSR = storageRef
                .child("users")
                .child(userUID)
                .child("profilePic.jpg");
            await userSR.putFile(compressedFile).then((ts) async {
              await ts.ref.getDownloadURL().then((url) async {
                rxPhoto.value = url;
                await userDR.update({
                  "$unIndexed.${uss.photoURL}": url,
                });
              });
            });
          });
          isLoading.value = false;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Profile photo"),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Obx(() => isLoading.value
              ? const CircularProgressIndicator()
              : InteractiveViewer(
                  clipBehavior: Clip.none,
                  child: Obx(() => CachedNetworkImage(imageUrl: rxPhoto.value)),
                )),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.maxFinite,
        height: 110,
        color: Colors.black,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 25),
            child: Column(
              children: [
                const Text(
                  "Change photo from",
                  textScaleFactor: 1.3,
                  style: TextStyle(color: Colors.white70),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GFButton(
                        color: Colors.white70,
                        type: GFButtonType.outline,
                        child: Row(
                          children: const [
                            Icon(MdiIcons.cameraOutline, color: Colors.white70),
                            SizedBox(width: 10),
                            Text("Camera"),
                          ],
                        ),
                        onPressed: () async {
                          await pickPhoto(ImageSource.camera);
                        }),
                    GFButton(
                        color: Colors.white70,
                        type: GFButtonType.outline,
                        child: Row(
                          children: const [
                            Icon(MdiIcons.imageOutline, color: Colors.white70),
                            SizedBox(width: 10),
                            Text("Gallery"),
                          ],
                        ),
                        onPressed: () async {
                          await pickPhoto(ImageSource.gallery);
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
