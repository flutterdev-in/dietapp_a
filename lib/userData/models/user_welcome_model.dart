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
  var googleCreationTime;
  var googleLastSignInTime;
  String? photoURL;
  String? displayName;
  String nativeLanguage;
  String bioData;

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
    required this.userID ,
    this.nativeLanguage = "English",
    this.bioData = "",
  });

  Map<String, dynamic> toMap() {
    return {
      "firebaseUID": firebaseUID,
      "userID": userID,
      "googleData": {
        "googleDisplayName": googleDisplayName,
        "googleEmail": googleEmail,
        "googlePhotoURL": googlePhotoURL,
        "googleIsEmailVerified": googleIsEmailVerified,
        "googleIsAnonymous": googleIsAnonymous,
        "googlePhoneNumber": googlePhoneNumber,
        "googleCreationTime": googleCreationTime,
        "googleLastSignInTime": googleLastSignInTime,
      },
      "profileData": {
        "userID": userID,
        "photoURL": photoURL,
        "displayName": displayName,
        "nativeLanguage": nativeLanguage,
        "bioData": bioData,
      }
    };
  }

  factory UserWelcomeModel.fromMap(Map userDocMap) {
    return UserWelcomeModel(
      firebaseUID: userDocMap["UID"],
      googleDisplayName: userDocMap["googleData"]["googleDisplayName"],
      googleEmail: userDocMap["googleData"]["googleEmail"],
      googlePhotoURL: userDocMap["googleData"]["googlePhotoURL"],
      googleIsEmailVerified: userDocMap["googleData"]["googleEmailVerified"],
      googleIsAnonymous: userDocMap["googleData"]["googleIsAnonymous"],
      googlePhoneNumber: userDocMap["googleData"]["googlePhoneNumber"],
      googleCreationTime: userDocMap["googleData"]["googleCreationTime"],
      googleLastSignInTime: userDocMap["googleData"]["googleLastSignInTime"],
      userID: userDocMap["userID"],
      photoURL: userDocMap["profileData"]["photoURL"],
      displayName: userDocMap["profileData"]["displayName"],
      nativeLanguage: userDocMap["profileData"]["nativeLanguage"],
      bioData: userDocMap["profileData"]["bioData"],
    );
  }
}
