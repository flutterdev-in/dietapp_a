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
}
