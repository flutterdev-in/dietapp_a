import 'package:cloud_firestore/cloud_firestore.dart';

class UserWelcomeModel {
  String? firebaseUID;
  String? userID;

  String? googleDisplayName;
  String? googleEmail;
  String? googlePhotoURL;
  bool? googleIsEmailVerified;
  bool? googleIsAnonymous;
  String? googlePhoneNumber;
  Timestamp googleCreationTime;
  Timestamp googleLastSignInTime;
  String? photoURL;
  String? displayName;
  String nativeLanguage;
  String bioData;

  String activity;
  Timestamp activeFrom;
  Timestamp pausedFrom;
  Timestamp inactiveFrom;

  UserWelcomeModel({
    required this.firebaseUID,
    required this.googleDisplayName,
    required this.googleEmail,
    required this.googlePhotoURL,
    required this.googleIsEmailVerified,
    required this.googleIsAnonymous,
    required this.googlePhoneNumber,
    required this.googleCreationTime,
    required this.googleLastSignInTime,
    required this.photoURL,
    required this.displayName,
    required this.userID,
    this.nativeLanguage = "English",
    this.bioData = "",
    this.activity = "active",
    required this.activeFrom,
    required this.pausedFrom,
    required this.inactiveFrom,
  });

  Map<String, dynamic> toMap() {
    return {
      uwms.firebaseUID: firebaseUID,
      uwms.userID: userID,
      uwms.googleData: {
        uwms.googleDisplayName: googleDisplayName,
        uwms.googleEmail: googleEmail,
        uwms.googlePhotoURL: googlePhotoURL,
        uwms.googleIsEmailVerified: googleIsEmailVerified,
        uwms.googleIsAnonymous: googleIsAnonymous,
        uwms.googlePhoneNumber: googlePhoneNumber,
        uwms.googleCreationTime: googleCreationTime,
        uwms.googleLastSignInTime: googleLastSignInTime,
      },
      uwms.profileData: {
        uwms.photoURL: photoURL,
        uwms.displayName: displayName,
        uwms.nativeLanguage: nativeLanguage,
        uwms.bioData: bioData,
      },
      uwms.userActivity: {
        uwms.activity: activity,
        uwms.activeFrom: activeFrom,
        uwms.pausedFrom: pausedFrom,
        uwms.inactiveFrom: inactiveFrom,
      }
    };
  }

  factory UserWelcomeModel.fromMap(Map userDocMap) {
    return UserWelcomeModel(
      firebaseUID: userDocMap[uwms.firebaseUID],
      googleDisplayName: userDocMap[uwms.googleData][uwms.googleDisplayName],
      googleEmail: userDocMap[uwms.googleData][uwms.googleEmail],
      googlePhotoURL: userDocMap[uwms.googleData][uwms.googlePhotoURL],
      googleIsEmailVerified: userDocMap[uwms.googleData]
          [uwms.googleIsEmailVerified],
      googleIsAnonymous: userDocMap[uwms.googleData][uwms.googleIsAnonymous],
      googlePhoneNumber: userDocMap[uwms.googleData][uwms.googlePhoneNumber],
      googleCreationTime: userDocMap[uwms.googleData][uwms.googleCreationTime],
      googleLastSignInTime: userDocMap[uwms.googleData]
          [uwms.googleLastSignInTime],
      userID: userDocMap[uwms.userID],
      photoURL: userDocMap[uwms.profileData][uwms.photoURL],
      displayName: userDocMap[uwms.profileData][uwms.displayName],
      nativeLanguage: userDocMap[uwms.profileData][uwms.nativeLanguage],
      bioData: userDocMap[uwms.profileData][uwms.bioData],
      activity: userDocMap[uwms.userActivity][uwms.activity],
      activeFrom: userDocMap[uwms.userActivity][uwms.activeFrom],
      pausedFrom: userDocMap[uwms.userActivity][uwms.pausedFrom],
      inactiveFrom: userDocMap[uwms.userActivity][uwms.inactiveFrom],
    );
  }
}

UserWelcomeModelStrings uwms = UserWelcomeModelStrings();

class UserWelcomeModelStrings {
  String firebaseUID = "firebaseUID";
  String userID = "userID";

  String chatMembers = "chatMembers";
  String lastChatTime = "lastChatTime";
  String chatRooms = "ChatRooms";
  String chatDocID = "chatDocID";

  String profileData = "profileData";
  String photoURL = "photoURL";
  String displayName = "displayName";

  String nativeLanguage = "nativeLanguage";
  String bioData = "bioData";
  String userActivity = "userActivity";
  String activity = "activity";

  String activeFrom = "activeFrom";
  String pausedFrom = "pausedFrom";
  String inactiveFrom = "inactiveFrom";

  String googleData = "googleData";
  String googleDisplayName = "googleDisplayName";
  String googleEmail = "googleEmail";
  String googlePhotoURL = "googlePhotoURL";

  String googleIsEmailVerified = "googleIsEmailVerified";
  String googleIsAnonymous = "googleIsAnonymous";
  String googlePhoneNumber = "googlePhoneNumber";
  String googleCreationTime = "googleCreationTime";

  String googleLastSignInTime = "googleLastSignInTime";
}
