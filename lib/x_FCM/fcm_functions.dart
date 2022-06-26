import 'package:cached_network_image/cached_network_image.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/_chat_room_screen.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'fcm_variables.dart';
import 'package:js/js.dart';
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

  static Future<void> setupInteractedBackroundMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    Future<void> _handleMessage(RemoteMessage message) async {
      var msgData = message.data;
      String? chatPersonUID = msgData["chatPersonUID"];
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

  //

  static void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) async {
      var msgData = msg.data;
      String? isRecieverOnChat = msgData["isRecieverOnChat"];

      if (isRecieverOnChat != "t") {
        var notification = msg.notification;
        var android = msg.notification?.android;
        if (notification != null && android != null) {
          // String? largeIconPath;
          // if (notification.android?.smallIcon != null) {
          //   Future<String> _downloadAndSaveFile(
          //       String url, String fileName) async {
          //     final directory = await getApplicationDocumentsDirectory();
          //     final String filePath = '${directory.path}/$fileName';
          //     final http.Response response = await http.get(Uri.parse(url));
          //     final File file = File(filePath);
          //     await file.writeAsBytes(response.bodyBytes);
          //     return filePath;
          //   }

          //   largeIconPath = await _downloadAndSaveFile(
          //       notification.android!.smallIcon!, 'largeIcon');
          // }
          // flutterLocalNotificationsPlugin.show(
          //   notification.hashCode,
          //   notification.title,
          //   notification.body ?? "foreground",
          //   NotificationDetails(
          //     android: AndroidNotificationDetails(androidNotificationChannel.id,
          //         androidNotificationChannel.name,
          //         channelDescription: androidNotificationChannel.description,
          //         icon: "@mipmap/ic_launcher",
          //         largeIcon: largeIconPath != null
          //             ? FilePathAndroidBitmap(largeIconPath)
          //             : null,
          //         importance: androidNotificationChannel.importance),
          //   ),
          // );

          Get.snackbar(
              notification.title ?? "", notification.body ?? "New message",
              titleText: notification.android!.smallIcon != null
                  ? Row(
                      children: [
                        SizedBox(
                          width: 30,
                          child: GFAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                notification.android!.smallIcon!),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(notification.title ?? "", softWrap: true),
                      ],
                    )
                  : null,
              messageText:
                  // Text(notification.body ?? "New message",
                  //                   softWrap: true, maxLines: 3),
                  android.imageUrl != null
                      ? Row(
                          children: [
                            SizedBox(
                                width: 90,
                                height: 60,
                                child: CachedNetworkImage(
                                    imageUrl: android.imageUrl!)),
                            SizedBox(
                                height: 60,
                                width: Get.width - 60 - 85,
                                child: Text(
                                  notification.body ?? "New message",
                                  softWrap: true,
                                ))
                          ],
                        )
                      : null,
              duration: const Duration(seconds: 5),
              isDismissible: true,
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
}
