import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';

class UserGoogleModel {
  //
  String? googleDisplayName;
  String? googleEmail;
  String? googlePhotoURL;
  bool? googleIsEmailVerified;
  bool? googleIsAnonymous;
  String? googlePhoneNumber;
  Timestamp googleCreationTime;
  Timestamp googleLastSignInTime;

  UserGoogleModel({
    required this.googleDisplayName,
    required this.googleEmail,
    required this.googlePhotoURL,
    required this.googleIsEmailVerified,
    required this.googleIsAnonymous,
    required this.googlePhoneNumber,
    required this.googleCreationTime,
    required this.googleLastSignInTime,
  });

  Map<String, dynamic> toMap() {
    return {
      uss.googleData: {
        uss.googleDisplayName: googleDisplayName,
        uss.googleEmail: googleEmail,
        uss.googlePhotoURL: googlePhotoURL,
        uss.googleIsEmailVerified: googleIsEmailVerified,
        uss.googleIsAnonymous: googleIsAnonymous,
        uss.googlePhoneNumber: googlePhoneNumber,
        uss.googleCreationTime: googleCreationTime,
        uss.googleLastSignInTime: googleLastSignInTime,
      },
    };
  }

  factory UserGoogleModel.fromMap(Map userDocMap) {
    return UserGoogleModel(
      googleDisplayName: userDocMap[uss.googleData][uss.googleDisplayName],
      googleEmail: userDocMap[uss.googleData][uss.googleEmail],
      googlePhotoURL: userDocMap[uss.googleData][uss.googlePhotoURL],
      googleIsEmailVerified: userDocMap[uss.googleData]
          [uss.googleIsEmailVerified],
      googleIsAnonymous: userDocMap[uss.googleData][uss.googleIsAnonymous],
      googlePhoneNumber: userDocMap[uss.googleData][uss.googlePhoneNumber],
      googleCreationTime: userDocMap[uss.googleData][uss.googleCreationTime],
      googleLastSignInTime: userDocMap[uss.googleData]
          [uss.googleLastSignInTime],
    );
  }
}
