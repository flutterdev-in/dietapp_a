import 'package:dietapp_a/hive%20Boxes/box_names.dart';
import 'package:dietapp_a/myapp.dart';
import 'package:dietapp_a/x_FCM/fcm_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'v_chat/models/chat_room_model.dart';
import 'x_FCM/fcm_variables.dart';

const AndroidNotificationChannel androidNotificationChannel =
    AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await fcmMain();
  await openHiveBoxes();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

Future<void> fcmMain() async {
  await FCMfunctions.fcmSettings();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidNotificationChannel);
  FirebaseMessaging.onBackgroundMessage(FCMfunctions.backgroundMsgHandler);

  await fcm.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<void> openHiveBoxes() async {
  await Hive.initFlutter();
  await Hive.openBox(crs.chatBox);
  await Hive.openBox(BoxNames.indexes);
  await Hive.openBox(BoxNames.services);
  Hive.openBox(BoxNames.favWebPages);
}
