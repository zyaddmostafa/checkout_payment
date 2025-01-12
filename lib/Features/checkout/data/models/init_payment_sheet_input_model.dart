class InitPaymentSheetInputModel {
  final String clientSecret;
  final String customerId;
  final String ephmeralKeySecret;

  InitPaymentSheetInputModel(
      {required this.clientSecret,
      required this.ephmeralKeySecret,
      required this.customerId});
}
