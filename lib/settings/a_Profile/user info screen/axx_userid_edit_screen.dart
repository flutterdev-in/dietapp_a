import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class ProfileIdEdit extends StatelessWidget {
  const ProfileIdEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Connectivity connectivity = Connectivity();
    List args = Get.arguments;
    String originalID0 = args[1].replaceAll("@gmail.com", "");
    String currentID0 = args[0].replaceAll("@", "");
    String originalID = "@$originalID0";
    Rx<String> rxID = "@$currentID0".obs;
    Rx<String> rxValid = "".obs;

    Widget textField() {
      TextEditingController tc = TextEditingController();
      tc.text = args[0].replaceAll("@", "");
      tc.selection =
          TextSelection.fromPosition(TextPosition(offset: tc.text.length));

      Widget validatorIcon() {
        if (rxValid.value == "current") {
          return Text("");
        } else if (rxValid.value == "original") {
          return Icon(
            Icons.done_all,
          );
        } else if (rxValid.value == "<8" || rxValid.value == "inValid") {
          return Icon(
            Icons.cancel,
          );
        } else if (rxValid.value == ">=8") {
          return Icon(
            Icons.close,
          );
        } else if (rxValid.value == "CheckConnectivity") {
          return Icon(
            Icons.change_circle,
          );
        } else if (rxValid.value == "timeout" || rxValid.value == "offline") {
          return Icon(
            Icons.signal_cellular_nodata,
          );
        } else if (rxValid.value == "Connecting to Fire") {
          return GFAvatar(
            child: GFLoader(
              loaderstrokeWidth: 3,
            ),
            backgroundColor: Colors.transparent,
            size: GFSize.SMALL,
          );
        } else if (rxValid.value == "taken") {
          return Text("taken");
        } else if (rxValid.value == "available") {
          return Icon(
            Icons.check_circle,
          );
        } else {
          return Text("");
        }
      }

      return TextField(
        controller: tc,
        maxLength: 20,
        onChanged: (value) async {
          int s = 0;
          int a = 0;
          if (value == currentID0) {
            rxValid.value = "current";
          } else if (value == originalID0) {
            rxValid.value = "original";
            rxID.value = value;
          } else if (value.length < 8) {
            rxValid.value = "<8";
          } else {
            rxValid.value = ">=8";
            for (String i in value.split('')) {
              if (Alphabets().special.contains(i)) {
                s++;
              }
              if (Alphabets().alpha.contains(i)) {
                a++;
              }
            }
            if ((s == 1 || s == 2) && s + a == value.length) {
              rxValid.value = "CheckConnectivity";
              Stopwatch stopwatch = Stopwatch()..start();
              Stopwatch stopwatch2 = Stopwatch()..start();
              InternetConnectionStatus isConnected =
                  await InternetConnectionChecker().connectionStatus;
              stopwatch.stop();
              if (stopwatch.elapsed > Duration(seconds: 2)) {
                rxValid.value = "timeout";
              }
              if (isConnected == InternetConnectionStatus.connected) {
                rxValid.value = "Connecting to Fire";
                await Future.delayed(const Duration(milliseconds: 700));
                Stopwatch stopwatch3 = Stopwatch()..start();
                await FirebaseFirestore.instance
                    .collection('Users')
                    .where('userID', isEqualTo: "@$value")
                    .limit(1)
                    .get()
                    .then((qs) {
                  stopwatch3.stop();
                  if (stopwatch3.elapsed > Duration(seconds: 2)) {
                    rxValid.value = "timeout";
                  } else if (qs.docs.length == 0) {
                    rxValid.value = "available";
                    rxID.value = value;
                  } else {
                    rxValid.value = "taken";
                  }
                });
              } else {
              
              }
              stopwatch2.stop();
              if (stopwatch2.elapsed > Duration(seconds: 2)) {
                rxValid.value = "timeout";
              } else {
                rxValid.value == "inValid";
              }
            }
          }
        },
        decoration: InputDecoration(
          icon: SizedBox(
            width: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.person_search,
                  size: 30,
                  color: Colors.blue,
                ),
                Text("@")
              ],
            ),
          ),
          suffixIcon: Obx(() => validatorIcon()),
        ),
      );
    }

    Widget richText() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "*    Your original Profile ID ",
              style: TextStyle(color: Colors.black)),
          TextSpan(
              text: originalID,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          TextSpan(
            text: " is always available to you to change back any time.",
            style: TextStyle(color: Colors.black),
          ),
        ])),
      );
    }

    Widget validationText() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            "*    New Profile ID should be in alphanumeric and must contain atleast one special character {  _  -  !  *  ~  } and atmost two special characters."),
      );
    }

    Widget appBarSaveIcon() {
      String v = rxValid.value;
      String u = rxID.value;
      Rx<String> rxB = "Change".obs;

      Widget icon() {
        if (rxB.value == "started") {
          return const GFAvatar(
            child: GFLoader(
              loaderstrokeWidth: 3,
            ),
            backgroundColor: Colors.transparent,
            size: GFSize.SMALL,
          );
        }
        if (rxB.value == "timeout") {
          return const GFAvatar(
            child: Icon(
              Icons.signal_cellular_nodata,
            ),
          );
        }
        if (rxB.value == "invalid") {
          return const Icon(
            Icons.error_outline,
          );
        }
        if (rxB.value == "success") {
          return const Icon(
            Icons.task_alt,
          );
        } else {
          return const Text(
            "Change",
            textScaleFactor: 1.3,
            style: TextStyle(color: Colors.white),
          );
        }
      }

      Future<void> onpress() async {
      
        if (rxValid.value == "original" || rxValid.value == "available") {
         
          rxB.value = "started";
          Stopwatch stopwatch3 = Stopwatch()..start();
          await FirebaseFirestore.instance
              .collection('Users')
              .where('userID', isEqualTo: "@$u")
              .limit(1)
              .get()
              .then((qs) async {
            stopwatch3.stop();
            if (stopwatch3.elapsed < const Duration(seconds: 2) &&
                qs.docs.isEmpty) {
              await userDR.update({"userID": rxID.value});
              rxB.value = "success";

              Get.snackbar(
                "Profile ID changed successfully",
                "Your new Profile ID : @${rxID.value}",
                snackPosition: SnackPosition.BOTTOM,
              );

              await Future.delayed(const Duration(seconds: 2));
              Navigator.pop(context);
            } else {
              rxB.value = "timeout";
              Get.snackbar(
                "Network Error",
                "Please try again later",
                snackPosition: SnackPosition.BOTTOM,
              );
              await Future.delayed(const Duration(seconds: 5));
              rxB.value = "Change";
            }
          });
        } else {
       
          rxB.value = "invalid";
          Get.snackbar(
            "Something went wrong",
            "Please check and try again",
            snackPosition: SnackPosition.BOTTOM,
          );
          await Future.delayed(const Duration(seconds: 5));
          rxB.value = "Change";
        }
      }

      return GFButton(
          size: GFSize.SMALL,
          color: Colors.transparent,
          child: Obx(
            () => icon(),
          ),
          onPressed: () async {
            await onpress();
          });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile ID'),
          actions: [appBarSaveIcon()],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              textField(),
              SizedBox(height: 10),
              richText(),
              validationText(),
            ],
          ),
        ),
      ),
    );
  }
}

class Alphabets {
  List<String> alpha = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    'p',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0'
  ];

  List<String> special = ['_', '-', '!', '*', '~'];
}
