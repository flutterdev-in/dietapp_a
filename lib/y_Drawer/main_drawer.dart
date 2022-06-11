import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:dietapp_a/y_Drawer/widgets/profile_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          const DrawerProfileContainer(),
          const SizedBox(height: 10),
          _widget(
            "Trackers",
            Icons.list,
          ),
          _widget(
            "My Foods",
            MdiIcons.food,
          ),
          _divider(),
          _widget(
            "Settings",
            MdiIcons.cogOutline,
          ),
          logout(),
          _widget(
            "About",
            MdiIcons.informationOutline,
          ),
        ],
      ),
    );
  }

  Widget _widget(
    String titile,
    IconData icon,
  ) {
    return GFListTile(
      avatar: Icon(
        icon,
      ),
      padding: const EdgeInsets.all(0),
      titleText: titile,
    );
  }

  Widget _divider() {
    return const Divider(thickness: 1);
  }

  Widget logout() {
    return GFListTile(
        avatar: const Icon(
          MdiIcons.logout,
        ),
        padding: const EdgeInsets.all(0),
        titleText: "Logout",
        onTap: () async {
          await GoogleSignIn().disconnect();
          await FirebaseAuth.instance.signOut();

          await userDR.update({
            "${uss.userActivity}.${uss.isActive}": false,
            "${uss.userActivity}.${uss.inactiveAt}":
                Timestamp.fromDate(DateTime.now()),
          });
        });
  }
}
