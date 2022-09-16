import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

//
LootAnimations loot = LootAnimations();

class LootAnimations {
  Widget sqareDotsLoading() {
    return Lottie.asset("assets/99354-loading.json", repeat: true);
  }

  Widget linerDotsLoading() {
    return Lottie.asset("assets/71814-loading-dots.json", repeat: true);
  }

  Widget plus() {
    return Lottie.asset("assets/68403-post-a-freelance-project.json",
        repeat: false);
  }

  Widget duplicate() {
    return Lottie.asset("assets/86284-bouncing-shapes.json", repeat: false);
  }

  Widget adfree() {
    return Lottie.asset("assets/14933-go-premium-ad-free.json", repeat: true);
  }

  Widget send() {
    return Lottie.asset("assets/10360-done.json", repeat: false);
  }

  Widget delete() {
    return Lottie.asset("assets/79053-delete-message.json", repeat: false);
  }

  Widget addRight() {
    return Lottie.asset("96295-success-popup.json", repeat: false);
  }
}
