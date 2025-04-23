import 'dart:convert';

import 'package:floward_weather/features/weather/domain/entities/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/weather_model.dart';
import 'weather_local_datasource.dart';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String cachedWeather = 'CACHED_WEATHER';

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Weather> getLastWeather() async {
    final jsonString = sharedPreferences.getString(cachedWeather);
    if (jsonString != null) {
      return WeatherModel.fromJson(json.decode(jsonString));
    } else {
      throw Exception('No cached weather found');
    }
  }

  @override
  Future<void> cacheWeather(Weather weather) async {
    if (weather is WeatherModel) {
      await sharedPreferences.setString(
        cachedWeather,
        json.encode(weather.toJson()),
      );
    }
  }
}
