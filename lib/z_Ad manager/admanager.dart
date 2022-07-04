import 'package:google_mobile_ads/google_mobile_ads.dart';

AdManager adManager = AdManager();

class AdManager {
  Future<void> loadAd() async {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {}, onAdFailedToLoad: (error) {}));
  }
}
