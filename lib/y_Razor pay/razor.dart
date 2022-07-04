import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/y_Razor%20pay/payment_model.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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

  // Future<String?> getOrderId() async {
  //   HttpsCallable callable =
  //       FirebaseFunctions.instance.httpsCallable('razorOrderId');

  //   final resp = await callable.call(<String, dynamic>{
  //     "amount": 4900, // amount in the smallest currency unit
  //     "currency": "INR",
  //   });

  //   Get.snackbar("title", resp.data.toString());
  //   return resp.data;
  // }

  // Future<Map<String, dynamic>?> razorOrder() async {
  //   // String? id = await getOrderId();

  //   // if (id != null) {
  //   return {
  //     'key': 'rzp_live_4luVs57V0YlLQD',
  //     'amount': 200, //in the smallest currency sub-unit.
  //     'name': 'DietApp',
  //     // 'order_id': id, // Generate order_id using Orders API
  //     // 'description': 'Fine T-Shirt',
  //     // 'timeout': 60, // in seconds
  //     'prefill': {
  //       'contact': currentUser?.phoneNumber ?? '',
  //       'email': currentUser?.email ?? ''
  //     }
  //   };
  //   // }
  //   // return null;
  // }
}
