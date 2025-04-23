import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/weather.dart';
import '../models/weather_model.dart';
import 'weather_local_datasource.dart';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String CACHED_WEATHER = 'CACHED_WEATHER';

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Weather> getLastWeather() async {
    final jsonString = sharedPreferences.getString(CACHED_WEATHER);
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
        CACHED_WEATHER,
        json.encode(weather.toJson()),
      );
    }
  }
}
