import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/x_customWidgets/stream_builder_functions.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:flutter/material.dart';

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return StreamBuilder(
          stream: FireRef().userDocStrem,
          builder: (c, AsyncSnapshot<DocumentSnapshot> d) {
            var data = SB().docStream(c, d);
            if (data is Map) {
              UserWelcomeModel uwm = UserWelcomeModel.fromMap(data);
              return IconButton(
                  icon: Image.network(uwm.photoURL!),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  });
            } else {
              return IconButton(
                  icon: data,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  });
            }
          });
    });
  }
}
