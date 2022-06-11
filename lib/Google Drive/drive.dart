import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as gdrive;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class DriveDetails {
  final String driveClientID =
      "237115759240-ibrn01vn4bprdsh9erk6ln7tnl49mq9n.apps.googleusercontent.com";
}

class DriveService {
  List<String> scopes = [gdrive.DriveApi.driveAppdataScope];

  final _googleSignIn = GoogleSignIn(
    scopes: <String>[gdrive.DriveApi.driveAppdataScope],
    clientId:
        "237115759240-ibrn01vn4bprdsh9erk6ln7tnl49mq9n.apps.googleusercontent.com",
  );

  getHttpClient() async {
    await _googleSignIn.signIn();

    // return await clientViaUserConsent(
    //     ClientId(DriveDetails().driveClientID), scopes, prompt);
    return await _googleSignIn.authenticatedClient();
  }

  prompt(String url) {
    launch(url);
  }

  upload(XFile file) async {
    var client = await getHttpClient();
    Get.snackbar("_googleSignIn.clientId".toString(), "");
    var drive = gdrive.DriveApi(client);
    int length = await file.length();

    await drive.files.create(
      gdrive.File(),
      uploadMedia: gdrive.Media(file.openRead(), length),
    );

    Get.back();
    //
  }
}
