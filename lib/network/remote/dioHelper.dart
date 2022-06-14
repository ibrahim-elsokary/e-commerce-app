import 'package:dio/dio.dart';
import 'package:first_app/network/remote/endPoint.dart';

class DioHelper {
  static Dio? dio;



  static initShop() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      String? lang = 'en',
      String? token,
      String? auth}) async {
    dio?.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic>? data,
      String? lang = 'en',
      String? auth}) async {
    dio?.options.headers = {
      'lang': lang,
      'Authorization': auth,
      'Content-Type': 'application/json'
    };
    return await dio!.post(url, data: data);
  }
}
