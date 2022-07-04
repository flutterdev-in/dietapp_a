import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManagerController extends GetxController {
  InterstitialAd? intAd;
  @override
  void onInit() {
    loadInterstitialAd();
    super.onInit();
  }

  @override
  void onClose() {
    showInterstitialAd();

    super.onClose();
  }

  Future<void> loadInterstitialAd() async {
    userDR.get().then((ds) async {
      if (ds.exists && ds.data() != null) {
        var uwm = UserWelcomeModel.fromMap(ds.data()!);
        if (uwm.paymentModel != null &&
            uwm.paymentModel!.expirationTime.isBefore(DateTime.now())) {
          InterstitialAd.load(
              // adUnitId: "ca-app-pub-7599104948188291~5161686907",
              adUnitId: "ca-app-pub-3940256099942544/1033173712",
              request: const AdRequest(),
              adLoadCallback: InterstitialAdLoadCallback(
                  onAdLoaded: (ad) {
                    intAd = ad;
                  },
                  onAdFailedToLoad: (error) {}));
        }
      }
    });
  }

  void showInterstitialAd() {
    if (intAd != null) {
      intAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) => intAd!.dispose(),
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          intAd?.dispose();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          intAd?.dispose();
        },
      );
      intAd?.show();
    }
  }
}
