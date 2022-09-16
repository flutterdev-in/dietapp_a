import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdController extends GetxController {
  Rx<int> days = 1.obs;
  @override
  void onInit() {
    myBannerAd.load();
    super.onInit();
  }

  @override
  void onClose() {
    myBannerAd.dispose();
    super.onClose();
  }

  final BannerAd myBannerAd = BannerAd(
    // adUnitId: "ca-app-pub-3940256099942544/6300978111", // test AD
    adUnitId: "ca-app-pub-7599104948188291~4817073212",
    size: AdSize.fullBanner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  // final BannerAdListener listener = BannerAdListener(
  //   // Called when an ad is successfully received.
  //   onAdLoaded: (Ad ad) => print('Ad loaded.'),
  //   // Called when an ad request failed.
  //   onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //     // Dispose the ad here to free resources.
  //     ad.dispose();
  //     print('Ad failed to load: $error');
  //   },
  //   // Called when an ad opens an overlay that covers the screen.
  //   onAdOpened: (Ad ad) => print('Ad opened.'),
  //   // Called when an ad removes an overlay that covers the screen.
  //   onAdClosed: (Ad ad) => print('Ad closed.'),
  //   // Called when an impression occurs on the ad.
  //   onAdImpression: (Ad ad) => print('Ad impression.'),
  // );
}

class BannerAdW extends StatelessWidget {
  BannerAdW({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    BannerAdController adc = Get.put(BannerAdController());
   
    return Container(
      alignment: Alignment.center,
      child: AdWidget(ad: adc.myBannerAd),
      width: adc.myBannerAd.size.width.toDouble(),
      height: adc.myBannerAd.size.height.toDouble(),
    );
  }
}
