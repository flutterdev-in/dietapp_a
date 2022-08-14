import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/hive%20Boxes/boxes.dart';
import 'package:dietapp_a/settings/a_Profile/basic%20info%20screen/basic_info_edit_screen.dart';
import 'package:dietapp_a/settings/user%20info%20screen/a_profile_first.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/x_FCM/fcm_variables.dart';
import 'package:dietapp_a/y_Razor%20pay/razor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'b_default timings/default_timings_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Razorpay razorpay = Razorpay();
  @override
  void initState() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, razor.onSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, razor.onError);

    super.initState();
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            const ProfileFirst(),
            const SizedBox(height: 10),
            // basic(),
            defaultFoodTimings(),
            razorPayW(),
            shareApp(),
            calculator(),
            logout(),
          ],
        ));
  }

  Widget basic() {
    return GFListTile(
      avatar: const Icon(
        Icons.manage_accounts,
      ),
      titleText: "Basic Information",
      subTitleText: "Gender,Age,Height,Weight,Activity",
      onTap: () {
        Get.to(() => BasicInfoEditScreen());
      },
    );
  }

  Widget defaultFoodTimings() {
    return GFListTile(
      avatar: const Icon(
        MdiIcons.wrenchClock,
      ),
      titleText: "Default Food Timings",
      onTap: () async {
        await Future.delayed(const Duration(milliseconds: 150));
        Get.to(() => const DefaultTimingsSettingsScreen());
      },
    );
  }

  Widget logout() {
    return GFListTile(
        avatar: const Icon(
          MdiIcons.logout,
        ),
        titleText: "Logout",
        onTap: () async {
          await Future.delayed(const Duration(milliseconds: 300));
          await removeFcmToken();
          await GoogleSignIn().disconnect();
          await FirebaseAuth.instance.signOut();

          // Restart.restartApp();
        });
  }

  Future<void> removeFcmToken() async {
    await userDR.update({
      "$unIndexed.${fcmVariables.fcmToken}": null,
    });
    await boxServices.delete(fcmVariables.fcmToken);
    // await boxServices.put(fcmVariables.fcmToken, null);
  }

  Widget razorPayW() {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: userDR.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.data() != null) {
            var uwm = UserWelcomeModel.fromMap(snapshot.data!.data()!);
            var isValid =
                uwm.paymentModel?.expirationTime.isAfter(DateTime.now()) ??
                    false;
            if (isValid) {
              var date = DateFormat("dd MMM yyyy")
                  .format(uwm.paymentModel!.expirationTime);
              return GFListTile(
                avatar: const Icon(MdiIcons.googleAds),
                // avatar: SizedBox(width: 30, height: 30, child: loot.adfree()),
                titleText: "No Ads",
                subTitleText: "Till $date",
              );
            } else {
              return GFListTile(
                avatar: const Icon(MdiIcons.googleAds),
                titleText: "Remove Ads",
                subTitleText: "Just Rs.49/- per month",
                onTap: () {
                  razorpay.open({
                    'key': 'rzp_live_4luVs57V0YlLQD',
                    'amount': 4900, //in the smallest currency sub-unit.
                    'name': 'DietApp',
                    // 'order_id': id, // Generate order_id using Orders API
                    // 'description': 'Fine T-Shirt',
                    // 'timeout': 60, // in seconds
                    'prefill': {
                      'contact': currentUser?.phoneNumber ?? '',
                      'email': currentUser?.email ?? ''
                    }
                  });
                },
              );
            }
          }

          return const SizedBox();
        });
  }

  Widget shareApp() {
    return GFListTile(
      avatar: const Icon(MdiIcons.shareVariant),
      titleText: "Share DietApp",
      subTitleText: "Keep supporting, Thank you",
      onTap: () {
        Share.share(
            "Hi, i found an innovative DietApp.\n\n\u{1F449}Very useful for Patients, Diabetes and Pregnant women.\n\u{1F449}Diet chat with anyone like WhatsApp.\n\u{1F449}View and Manage others diet in realtime.\n\u{1F449}Detect cheat diet with proof pictures.\n\u{1F449}Manage foods collection like FileManager.\n\u{1F449}Import your favorite foods from Websites or Youtube with inbuilt Web browser.\n\u{25B6}Install it from Playstore https://play.google.com/store/apps/details?id=in.dietapp");
      },
    );
  }

  Widget calculator() {
    return GFListTile(
      avatar: const GFAvatar(
        shape: GFAvatarShape.standard,
        size: GFSize.SMALL,
        backgroundImage: CachedNetworkImageProvider(
            "https://firebasestorage.googleapis.com/v0/b/dietapp-in.appspot.com/o/AI%20icon%20512.png?alt=media&token=a5c5b582-7f84-441c-8222-470de4bdf3e1"),
      ),
      titleText: "AI Calculator",
      subTitleText: "World first multiline calculator",
      onTap: () async {
        launchUrl(Uri.parse(
                "https://play.google.com/store/apps/details?id=com.aicalculator"))
            .catchError((e) {});
      },
    );
  }
}
