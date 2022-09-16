class PaymentModel {
  DateTime paymentTime;
  DateTime expirationTime;
  String paymentID;
  int amount;


  PaymentModel({
    required this.paymentTime,
    required this.expirationTime,
    required this.paymentID,
    required this.amount,
  
  });

  Map<String, dynamic> toMap() {
    return {
      paymentmos.paymentTime: paymentTime,
      paymentmos.expirationTime: expirationTime,
      paymentmos.paymentID: paymentID,
      paymentmos.amount: amount,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> paymentMap) {
    DateTime expireTime = paymentMap[paymentmos.expirationTime].toDate();

    return PaymentModel(
      paymentTime: paymentMap[paymentmos.paymentTime].toDate(),
      expirationTime: expireTime,
    
      paymentID: paymentMap[paymentmos.paymentID],
      amount: paymentMap[paymentmos.amount],
    );
  }
}

PaymentModelObjects paymentmos = PaymentModelObjects();

class PaymentModelObjects {
  final paymentTime = "paymentTime";
  final expirationTime = "expirationTime";
  final paymentID = "paymentID";
  final amount = "amount";
}
