import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:dietapp_a/x_FCM/fcm_variables.dart';

class UserWelcomeModel {
  String? firebaseUID;

  //
  String? fcmToken;

  String userID;
  String? photoURL;
  String displayName;
  String bioData;
  List userIdSearchStrings;
  List nameSearchStrings;

  //
  bool isActive;
  DateTime activeAt;
  DateTime inactiveAt;

  UserWelcomeModel({
    this.firebaseUID,
    required this.userID,
    required this.photoURL,
    required this.displayName,
    this.bioData = "",
    this.fcmToken,
    this.isActive = false,
    required this.userIdSearchStrings,
    required this.nameSearchStrings,
    required this.activeAt,
    required this.inactiveAt,
  });

  Map<String, dynamic> toMap() {
    return {
      uwmos.userIdSearchStrings: uwmos.getSearchStrings(userID),
      uwmos.nameSearchStrings: uwmos.getSearchStrings(displayName),
      uss.userID: userID,
      unIndexed: {
        fcmVariables.fcmToken: fcmToken,
        uss.photoURL: photoURL,
        uss.displayName: displayName,
        uss.bioData: bioData,
        uss.activeAt: Timestamp.fromDate(activeAt),
        uss.inactiveAt: Timestamp.fromDate(inactiveAt),
      }
    };
  }

  factory UserWelcomeModel.fromMap(Map userDocMap) {
    DateTime ina =
        userDocMap[unIndexed][uss.inactiveAt]?.toDate() ?? DateTime.now();
    DateTime act =
        userDocMap[unIndexed][uss.activeAt]?.toDate() ?? DateTime.now();
    bool isAct = (act != ina && act.isAfter(ina));

    return UserWelcomeModel(
      firebaseUID: null,
      nameSearchStrings: userDocMap[uwmos.nameSearchStrings],
      userIdSearchStrings: userDocMap[uwmos.userIdSearchStrings],
      userID: userDocMap[uss.userID],
      fcmToken: userDocMap[unIndexed][fcmVariables.fcmToken],

      //
      photoURL: userDocMap[unIndexed][uss.photoURL],
      displayName: userDocMap[unIndexed][uss.displayName],

      bioData: userDocMap[unIndexed][uss.bioData],
      //
      isActive: isAct,
      activeAt: userDocMap[unIndexed][uss.activeAt]?.toDate(),
      inactiveAt: userDocMap[unIndexed][uss.inactiveAt]?.toDate(),
    );
  }
}

UserWelcomeModelObjects uwmos = UserWelcomeModelObjects();

class UserWelcomeModelObjects {
  final String nameSearchStrings = "nameSearchStrings";
  final String userIdSearchStrings = "userIdSearchStrings";

  //
  List<String> getSearchStrings(String name, [int fromIndex = 3]) {
    name = name.toLowerCase();
    var name0 = name.substring(0, fromIndex);
    var l0 = name.substring(fromIndex).split("");
    var l = [name0];
    for (var i in l0) {
      name0 = name0 + i;
      l.add(name0);
    }

    return l;
  }
}
