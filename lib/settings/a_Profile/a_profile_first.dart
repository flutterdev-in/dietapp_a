import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/settings/a_Profile/ax_profile_edit.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/x_customWidgets/stream_builder_functions.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';

class ProfileFirst extends StatelessWidget {
  const ProfileFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FireRef().userDocStrem,
        builder: (c, AsyncSnapshot<DocumentSnapshot> d) {
          var data = docStreamReturn(c, d, widType: "");
          if (data is Map) {
            UserWelcomeModel uwm = UserWelcomeModel.fromMap(data);
            return Container(
              // color: Colors.green,
              padding: EdgeInsets.only(top: 15),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        CircleAvatar(
                          foregroundImage: NetworkImage(uwm.photoURL!),
                          minRadius: 60,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              uwm.displayName!,
                              textScaleFactor: 1.4,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              uwm.userID!,
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
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Get.to(() => ProfileEdit());
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
