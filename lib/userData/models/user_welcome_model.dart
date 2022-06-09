import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';

class UserWelcomeModel {
  String? firebaseUID;

  String userID;
  String? photoURL;
  String displayName;
  String bioData;

  //
  bool isActive;
  Timestamp activeAt;
  Timestamp inactiveAt;

  UserWelcomeModel({
    this.firebaseUID,
    required this.userID,
    required this.photoURL,
    required this.displayName,
    this.bioData = "",
    this.isActive = true,
    required this.activeAt,
    required this.inactiveAt,
  });

  Map<String, dynamic> toMap() {
    return {
      uss.userID: userID,
      uss.profileData: {
        uss.photoURL: photoURL,
        uss.displayName: displayName,
        uss.bioData: bioData,
      },
      uss.userActivity: {
        uss.isActive: isActive,
        uss.activeAt: activeAt,
        uss.inactiveAt: inactiveAt,
      }
    };
  }

  factory UserWelcomeModel.fromMap(Map userDocMap) {
    return UserWelcomeModel(
      firebaseUID: null,

      userID: userDocMap[uss.userID],

      //
      photoURL: userDocMap[uss.profileData][uss.photoURL],
      displayName: userDocMap[uss.profileData][uss.displayName],

      bioData: userDocMap[uss.profileData][uss.bioData],
      //
      isActive: userDocMap[uss.userActivity][uss.isActive],
      activeAt: userDocMap[uss.userActivity][uss.activeAt],
      inactiveAt: userDocMap[uss.userActivity][uss.inactiveAt],
    );
  }
}
