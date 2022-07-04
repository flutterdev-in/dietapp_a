import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/x_FCM/fcm_variables.dart';
import 'package:dietapp_a/y_Razor%20pay/payment_model.dart';

class UserWelcomeModel {
  String? firebaseUID;

  //
  String? fcmToken;

  String userID;
  String? photoURL;
  String displayName;
  String bioData;
  List userIdSearchStrings;

  PaymentModel? paymentModel;

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
    this.paymentModel,
    required this.activeAt,
    required this.inactiveAt,
  });

  Map<String, dynamic> toMap() {
    return {
      uwmos.userIdSearchStrings: uwmos.getSearchStrings(userID),
      uwmos.userID: userID,
      unIndexed: {
        fcmVariables.fcmToken: fcmToken,
        uwmos.photoURL: photoURL,
        uwmos.displayName: displayName,
        uwmos.bioData: bioData,
        uwmos.activeAt: Timestamp.fromDate(activeAt),
        uwmos.inactiveAt: Timestamp.fromDate(inactiveAt),
        uwmos.paymentModel: paymentModel?.toMap(),
      }
    };
  }

  factory UserWelcomeModel.fromMap(Map userDocMap) {
    DateTime ina =
        userDocMap[unIndexed][uwmos.inactiveAt]?.toDate() ?? DateTime.now();
    DateTime act =
        userDocMap[unIndexed][uwmos.activeAt]?.toDate() ?? DateTime.now();
    bool isAct = (act != ina && act.isAfter(ina));

    return UserWelcomeModel(
      firebaseUID: null,

      userIdSearchStrings: userDocMap[uwmos.userIdSearchStrings],
      userID: userDocMap[uwmos.userID],
      fcmToken: userDocMap[unIndexed][fcmVariables.fcmToken],

      //
      photoURL: userDocMap[unIndexed][uwmos.photoURL],
      displayName: userDocMap[unIndexed][uwmos.displayName],
      paymentModel: userDocMap[unIndexed][uwmos.paymentModel] != null
          ? PaymentModel.fromMap(userDocMap[unIndexed][uwmos.paymentModel])
          : null,

      bioData: userDocMap[unIndexed][uwmos.bioData],
      //
      isActive: isAct,
      activeAt: userDocMap[unIndexed][uwmos.activeAt]?.toDate(),
      inactiveAt: userDocMap[unIndexed][uwmos.inactiveAt]?.toDate(),
    );
  }
}

UserWelcomeModelObjects uwmos = UserWelcomeModelObjects();

class UserWelcomeModelObjects {
  final users = "Users";

  final userID = "userID";

  final photoURL = "photoURL";
  final displayName = "displayName";

  final bioData = "bioData";

  final activeAt = "activeAt";

  final inactiveAt = "inactiveAt";
  final userIdSearchStrings = "userIdSearchStrings";
  final paymentModel = "paymentModel";

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
