import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';

import 'package:dietapp_a/assets/assets.dart';
import 'package:dietapp_a/settings/a_Profile/axx_userid_edit_screen.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/x_customWidgets/stream_builder_functions.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: userDS,
        builder: (c, AsyncSnapshot<DocumentSnapshot> d) {
          var data = docStreamReturn(c, d, widType: "");
          if (data is Map) {
            UserWelcomeModel uwm = UserWelcomeModel.fromMap(data);
            Rx<String> rxName = "${uwm.displayName}".obs;
            Rx<String> rxBio = uwm.bioData.obs;

            Widget name() {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                child: TextFormField(
                  maxLength: 25,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    RegExp userD =
                        RegExp(r'(^[a-zA-Z]+[a-zA-Z0-9 ]+[a-zA-Z0-9]$)');
                    if (value == null || value == "") {
                      return "";
                    } else if (value.length < 6) {
                      return "Minimum 6 characters";
                    } else if (!userD.hasMatch(value)) {
                      return "Enter Valid Name : [A-Z/a-z][space][A-Z/a-z/0-9]";
                    } else {
                      rxName.value = value;
                    }
                  },
                  decoration: const InputDecoration(
                      icon: Icon(FontAwesomeIcons.fileSignature),
                      labelText: "Display Name"),
                  controller: TextEditingController(text: uwm.displayName),
                ),
              );
            }

            Widget bioData() {
              return Padding(
                padding: const EdgeInsets.fromLTRB(60, 0, 30, 0),
                child: TextField(
                  controller: TextEditingController(text: uwm.bioData),
                  maxLines: 3,
                  maxLength: 200,
                  decoration: const InputDecoration(labelText: "Bio"),
                  onChanged: (value) {
                    rxBio.value = value;
                  },
                ),
              );
            }

            Widget email() {
              return GFListTile(
                padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                avatar: GFAvatar(
                    child: SvgPicture.asset(Assets().googleIcon),
                    backgroundColor: Colors.transparent,
                    radius: 15),
                title: Text(userGoogleEmail, textScaleFactor: 1.2),
                // titleText: uwm.googleEmail,
              );
            }

            Widget userID() {
              return GFListTile(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                avatar: const Icon(
                  Icons.person_search,
                  size: 30,
                  color: Colors.blue,
                ),
                titleText: uwm.userID,
                icon: GFButton(
                  child: const Text(
                    "Change",
                    textScaleFactor: 1.2,
                  ),
                  type: GFButtonType.outline,
                  onPressed: () {
                    Get.to(() => const ProfileIdEdit(),
                        arguments: [uwm.userID, userGoogleEmail]);
                  },
                ),
              );
            }

            Widget submitButton() {
              Rx<String> rxButton = "tick".obs;
              Widget iconText() {
                if (rxButton.value == "tick") {
                  return const Icon(
                    Icons.done,
                  );
                } else if (rxButton.value == "connecting") {
                  return const GFAvatar(
                    size: 16,
                    backgroundColor: Colors.transparent,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                } else if (rxButton.value == "error") {
                  return const Icon(
                    Icons.running_with_errors,
                  );
                } else {
                  return const Icon(
                    Icons.task_alt,
                    size: 28,
                  );
                }
              }

              return GFButton(
                color: Colors.transparent,
                child: Obx(() {
                  return iconText();
                }),
                onPressed: () async {
                  rxButton.value = "connecting";
                  if (rxName.value != uwm.displayName ||
                      rxBio.value != uwm.bioData) {
                    await userDR.update({
                      "profileData": {
                        "displayName": rxName.value,
                        "bioData": rxBio.value,
                        "photoURL": uwm.photoURL,
                      },
                    }).then((value) {
                      rxButton.value = "updated";
                    });
                  }
                  await Future.delayed(const Duration(seconds: 1));
                  rxButton.value = "done";

                  Get.snackbar(
                    "Profile details updated",
                    "",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.pop(context);
                },
              );
            }

            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Profile"),
                  actions: [submitButton()],
                ),
                body: ListView(
                  children: [
                    email(),
                    userID(),
                    name(),
                    bioData(),
                  ],
                ),
              ),
            );
          }
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(),
              body: data,
            ),
          );
        });
  }
}
