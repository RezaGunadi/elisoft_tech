import 'package:child_care/configs/base_url_config.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<Response> registerUser(Map<String, dynamic>? userData) async {
    try {
      Response response = await _dio.post(
        "${BaseUrlConfig.baseUrlApi}/regist", //ENDPONT URL
          data: userData, //REQUEST BODY
          // queryParameters: {'apikey': 'YOUR_API_KEY'}, //QUERY PARAMETERS
          // options: Options(headers: {
          //   'X-LoginRadius-Sott': 'YOUR_SOTT_KEY', //HEADERS
          // })
          );
      //returns the successful json object
      return response.data;
    } on DioError catch (e) {
      //returns the error object if there is
      return e.response!.data;
    }
  }

  Future<Response> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        "${BaseUrlConfig.baseUrlApi}/login",
        data: {'email': email, 'password': password},
        // queryParameters: {'apikey': 'YOUR_API_KEY'},
      );
      //returns the successful user data json object
      return response.data;
    } on DioError catch (e) {
      //returns the error object if any
      return e.response!.data;
    }
  }

}
