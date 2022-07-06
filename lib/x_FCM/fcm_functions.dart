import 'package:cached_network_image/cached_network_image.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/hive%20Boxes/boxes.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/_chat_room_screen.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'fcm_variables.dart';

class FCMfunctions {
  //
  static Future<void> backgroundMsgHandler(RemoteMessage msg) async {
    await Firebase.initializeApp();
    // var msgData = msg.data;
    // String? isRecieverOnChat = msgData["isRecieverOnChat"];

    // if (isRecieverOnChat != "t") {
    //   var notification = msg.notification;
    //   var android = msg.notification?.android;
    //   if (notification != null && android != null) {
    //     Future<String> _downloadAndSaveFile(String url, String fileName) async {
    //       final directory = await getApplicationDocumentsDirectory();
    //       final String filePath = '${directory.path}/$fileName';
    //       final http.Response response = await http.get(Uri.parse(url));
    //       final File file = File(filePath);
    //       await file.writeAsBytes(response.bodyBytes);
    //       return filePath;
    //     }

    //     String? largeIconPath;
    //     if (notification.android?.smallIcon != null) {
    //       largeIconPath = await _downloadAndSaveFile(
    //           notification.android!.smallIcon!, 'largeIcon');
    //     }

    //     flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body ?? "foreground",
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //             androidNotificationChannel.id, androidNotificationChannel.name,
    //             channelDescription: androidNotificationChannel.description,
    //             icon: "@mipmap/ic_launcher",
    //             largeIcon: largeIconPath != null
    //                 ? FilePathAndroidBitmap(largeIconPath)
    //                 : null,
    //             importance: androidNotificationChannel.importance),
    //       ),
    //     );
    //   }
    // }
  }

  //
  static Future<void> fcmSettings() async {
    NotificationSettings settings = await fcm.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // flutterLocalNotificationsPlugin.initialize(
      //   const InitializationSettings(
      //     android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      //   ),
      //   // onSelectNotification: (payloadURI) async {
      //     // if (payloadURI != null && payloadURI.length > 10) {
      //     // var crm = await crs.chatRoomModelFromChatPersonUID(payloadURI);
      //     // Get.to(() => const ChatScreen());
      //     // }
      //   // },
      // );
    }
  }

  //
  static Future<void> checkFCMtoken() async {
    var tokenB = boxServices.get(fcmVariables.fcmToken);
    if (tokenB == null || tokenB != String) {
      var fcmToken = await fcm.getToken();
      await userDR.update({
        "$unIndexed.${fcmVariables.fcmToken}": fcmToken,
      });
      await boxServices.put(fcmVariables.fcmToken, fcmToken);
    }
  }

  //

  static void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) async {
      var msgData = msg.data;
      String? isRecieverOnChat = msgData["isRecieverOnChat"];

      if (isRecieverOnChat != "t") {
        var notification = msg.notification;
        var android = msg.notification?.android;
        if (notification != null && android != null) {
          Get.snackbar(
              notification.title ?? "", notification.body ?? "New message",
              duration: const Duration(seconds: 5),
              isDismissible: true,
              icon: notification.android!.smallIcon != null
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      child: GFAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            notification.android!.smallIcon!),
                      ),
                    )
                  : null,
              dismissDirection: DismissDirection.horizontal,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white, onTap: (snackbar) async {
            var crm = await crs
                .chatRoomModelFromChatPersonUID(msgData["chatPersonUID"]);
            Get.closeCurrentSnackbar();
            Get.to(() => ChatRoomScreen(crm));
          });
        }
      }
    });
  }

  static Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    void _handleMessage(RemoteMessage message) async {
      var chatPersonUID = message.data['chatPersonUID'];
      if (chatPersonUID != null) {
        var crm = await crs.chatRoomModelFromChatPersonUID(chatPersonUID);

        Get.to(() => ChatRoomScreen(crm));
      }
    }

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }
}
