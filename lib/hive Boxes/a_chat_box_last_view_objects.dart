import 'package:hive_flutter/hive_flutter.dart';

Box chatBoxLastView = Hive.box(chatBoxLastViewObjects.chatBoxLastView);
ChatBoxLastViewObjects chatBoxLastViewObjects = ChatBoxLastViewObjects();

class ChatBoxLastViewObjects {
  final String chatBoxLastView = "chatBoxLastView";
  
}
