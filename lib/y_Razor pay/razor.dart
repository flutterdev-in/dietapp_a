import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'payment_model.dart';

Razor razor = Razor();

class Razor {
  Future<void> onSuccess(PaymentSuccessResponse response) async {
    if (response.paymentId != null) {
      var now = DateTime.now();
      var after1month = now.add(const Duration(days: 30));
      userDR.update({
        "$unIndexed.${uwmos.paymentModel}": PaymentModel(
                paymentTime: now,
                expirationTime: after1month,
                paymentID: response.paymentId!,
                amount: 4900)
            .toMap(),
      });
      Get.snackbar("Payment success", "Thanks for your support");
    } else {
      Get.snackbar("Payment Error", "Please try again");
    }
  }

  void onError(PaymentFailureResponse response) {
    Get.snackbar("Payment Error", "Please try again");
  }
}
