import 'package:dio/dio.dart';

abstract class DioHelper {
  Future<Response> getData(
      {Map<String, dynamic>? queryParameters, required String path});
  Future<Response> postData(String path, {Map<String, dynamic>? data});
}
