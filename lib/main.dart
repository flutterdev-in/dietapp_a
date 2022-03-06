import 'package:dietapp_a/myapp.dart';
import 'package:dietapp_a/v_chat/constants/chat_strings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox(crs.chatBox);
  runApp(const MyApp());
}
