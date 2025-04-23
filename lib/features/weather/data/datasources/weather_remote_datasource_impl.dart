import 'dart:convert';

import 'package:floward_weather/features/weather/domain/entities/weather.dart';
import 'package:http/http.dart' as http;

import '../../core/utils/constants.dart';
import '../models/weather_model.dart';
import 'weather_remote_datasource.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<Weather> getCurrentWeather(String cityName) async {
    final response = await client.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/weather?q=$cityName&appid=${ApiConstants.apiKey}&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
