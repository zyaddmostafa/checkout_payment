import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  Future<Response> post(
      {required Map<String, dynamic> body,
      required String url,
      required String token,
      String? contentType}) async {
    var response = await dio.post(
      url,
      data: body, // Convert the model to JSON before sending
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
