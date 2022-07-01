import 'package:cloud_functions/cloud_functions.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

Razor razor = Razor();

class Razor {
  Future<void> onSuccess(PaymentSuccessResponse response) async {
    if (response.orderId != null &&
        response.paymentId != null &&
        response.signature != null) {
      Get.snackbar("Payment success", response.orderId!);
    } else {
      Get.snackbar("Payment Error", "Please try again");
    }
  }

  void onError(PaymentFailureResponse response) {
    Get.snackbar("Payment sucess", response.message ?? "i2ehdhfhhfh");
  }

  void externalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  Future<String?> getOrderId() async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('razorOrderId');

    final resp = await callable.call(<String, dynamic>{
      "amount": 4900, // amount in the smallest currency unit
      "currency": "INR",
    });

    Get.snackbar("title", resp.data.toString());
    return resp.data;
  }

  Future<Map<String, dynamic>?> razorOrder() async {
    // String? id = await getOrderId();

    // if (id != null) {
    return {
      'key': 'rzp_live_4luVs57V0YlLQD',
      'amount': 1000, //in the smallest currency sub-unit.
      'name': 'DietApp',
      // 'order_id': id, // Generate order_id using Orders API
      // 'description': 'Fine T-Shirt',
      'timeout': 60, // in seconds
      'prefill': {
        'contact': currentUser?.phoneNumber ?? '',
        'email': currentUser?.email ?? ''
      }
    };
    // }
    // return null;
  }
}
