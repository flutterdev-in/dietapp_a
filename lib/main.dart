import 'package:dietapp_a/hive%20Boxes/box_names.dart';
import 'package:dietapp_a/myapp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'v_chat/models/chat_room_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await openHiveBoxes();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

Future<void> openHiveBoxes() async {
  await Hive.initFlutter();
  await Hive.openBox(crs.chatBox);
  await Hive.openBox(boxNames.indexes);
  Hive.openBox(boxNames.favWebPages);
}
