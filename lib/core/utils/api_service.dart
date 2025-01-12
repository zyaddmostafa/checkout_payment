import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_model/payment_intent_input_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  Future<Response> post(
      {required PaymentIntentInputModel body,
      required String url,
      required String token,
      String? contentType}) async {
    var response = await dio.post(
      url,
      data: body,
      options: Options(
        contentType: contentType,
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    return response;
  }
}
