import 'package:flutter/cupertino.dart';
import 'package:in_app_update/in_app_update.dart';

AppUpdater appUpdater = AppUpdater();

class AppUpdater {
  Future<void> checkAndUpdate(BuildContext context) async {
    InAppUpdate.checkForUpdate().then((appUpdateInfo) async {
      if (appUpdateInfo.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        await InAppUpdate.performImmediateUpdate().catchError((e) {});
      }
    });
  }
}
