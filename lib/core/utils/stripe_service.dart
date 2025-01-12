import 'package:checkout_payment_ui/Features/checkout/data/models/ephmeral_key_model/ephmeral_key_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/init_payment_sheet_input_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:checkout_payment_ui/core/utils/api_keys.dart';
import 'package:checkout_payment_ui/core/utils/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  final ApiService apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiService.post(
        contentType: Headers.formUrlEncodedContentType,
        body: paymentIntentInputModel.toJson(),
        url: 'https://api.stripe.com/v1/payment_intents',
        token: ApiKeys.secrtKey);

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

    return paymentIntentModel;
  }

  Future initPaymentSheet(
      {required InitPaymentSheetInputModel initPaymentSheetInputModel}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: initPaymentSheetInputModel.clientSecret,
      merchantDisplayName: 'Zyad',
      customerEphemeralKeySecret: initPaymentSheetInputModel.ephmeralKeySecret,
      customerId: initPaymentSheetInputModel.customerId,
    ));
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var ephmeralKeyModel =
        await createEphmeralKey(customid: paymentIntentInputModel.customerId);
    var initPaymentSheetInputModel = InitPaymentSheetInputModel(
        clientSecret: paymentIntentModel.clientSecret!,
        ephmeralKeySecret: ephmeralKeyModel.id!,
        customerId: paymentIntentInputModel.customerId);
    await initPaymentSheet(
        initPaymentSheetInputModel: initPaymentSheetInputModel);
    await displayPaymentSheet();
  }

  Future<EphmeralKeyModel> createEphmeralKey({required String customid}) async {
    var response = await apiService.post(
        contentType: Headers.formUrlEncodedContentType,
        body: {'customer': customid},
        url: ' https://api.stripe.com/v1/ephemeral_keys',
        token: ApiKeys.secrtKey,
        headers: {
          'Stripe-Version': '2024-12-18.acacia',
          'Authorization': 'Bearer ${ApiKeys.secrtKey}'
        });

    var ephmeralKey = EphmeralKeyModel.fromJson(response.data);

    return ephmeralKey;
  }
}
