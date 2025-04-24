import 'package:dio/dio.dart';
import 'package:floward_weather/core/network/dio_helper.dart';
import 'package:floward_weather/core/utils/endpoints.dart';

class DioHelperImpl implements DioHelper {
  final Dio dio;

  DioHelperImpl()
      : dio = Dio(
          BaseOptions(
            baseUrl: Endpoints.baseUrl,
            receiveDataWhenStatusError: true,
            connectTimeout: const Duration(seconds: 20),
            receiveTimeout: const Duration(seconds: 20),
          ),
        );

  @override
  Future<Response> getData(
      {Map<String, dynamic>? queryParameters, required String path}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
    };

    return await dio.get(path, queryParameters: queryParameters);
  }

  @override
  Future<Response> postData(String path, {Map<String, dynamic>? data}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
    return await dio.post(path, data: data);
  }
}
