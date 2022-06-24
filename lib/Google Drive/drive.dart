import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as gdrive;
import 'package:http/http.dart' as http;

class DriveDetails {
  final String driveClientID =
      "237115759240-ibrn01vn4bprdsh9erk6ln7tnl49mq9n.apps.googleusercontent.com";
}

class DriveService {
  // List<String> scopes = [gdrive.DriveApi.driveAppdataScope];

  // final _googleSignIn = GoogleSignIn(
  //   scopes: <String>[gdrive.DriveApi.driveAppdataScope],
  //   // clientId:
  //   //     "237115759240-4rom331hl9i9ulb891s1osmgj997484b.apps.googleusercontent.com",
  // );

  // getHttpClient() async {
  //   await _googleSignIn.signIn();

  // return await clientViaUserConsent(
  //     ClientId(DriveDetails().driveClientID), scopes, prompt);
  //   return await _googleSignIn.authenticatedClient();
  // }

  // prompt(String url) {
  //   launch(url);
  // }

  Future<void> upload(File file) async {
    final googleSignIn = GoogleSignIn.standard(scopes: [
      gdrive.DriveApi.driveAppdataScope,
    ]);
    final googleUser = await googleSignIn.signIn();

    final headers = await googleUser?.authHeaders;
    if (headers != null) {
      final client = GoogleAuthClient(headers);
      // // final _googleSignIn =
      // //     GoogleSignIn(scopes: [gdrive.DriveApi.driveAppdataScope]);
      // GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      // Get.snackbar(googleSignInAccount?.email ?? "jsjcn", "");
      // var client =  _googleSignIn.authenticatedClient();
      // // var client = await getHttpClient();
      // final headers = await googleUser?.authHeaders;
      // Get.snackbar("client.toString()", "");
      var drive = gdrive.DriveApi(client);

      // int length = await file.length();

      // Create data here instead of loading a file
      // const contents = "Technical Feeder";
      // final Stream<List<int>> mediaStream =
      //     Future.value(contents.codeUnits).asStream().asBroadcastStream();
      // // Set up File info
      // var driveFile = gdrive.File();

      // final timestamp = DateFormat("yyyy-MM-dd-hhmmss").format(DateTime.now());
      // driveFile.name = "technical-feeder-$timestamp.txt";
      // driveFile.modifiedTime = DateTime.now().toUtc();
      // driveFile.parents = ["appDataFolder"];
      // Get.snackbar(client._headers.toString(), "",
      //     duration: const Duration(seconds: 5));

      await FlutterNativeImage.compressImage(
        file.path,
        targetHeight: 800,
        targetWidth: 800,
      ).then((cFile) async {
         Get.snackbar(
          cFile.path.toString(),
          "",
        );
        
       var k = await drive.drives.get("jksnc");
       Get.snackbar(
          k.name.toString(),
          "",
        );
        await drive.files
            .create(
              gdrive.File(),
              uploadMedia: gdrive.Media(file.openRead(), await file.length()),
            )
            .then((value) => Get.snackbar(value.description.toString(), "",
                duration: const Duration(seconds: 5)));
      });

      // await drive.files
      //     .generateIds()
      //     .then((value) => Get.snackbar(client._headers.toString(), ""));
      // // .create(
      // //   gdrive.File(),
      // //   uploadMedia: gdrive.Media(file.openRead(), await file.length()),
      // // )
      // // .then((value) => print(value.createdTime));

      Get.back();
    }
  }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}
