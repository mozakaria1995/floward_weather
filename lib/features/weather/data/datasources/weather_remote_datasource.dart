import 'package:floward_weather/features/weather/domain/entities/weather.dart';

abstract class WeatherRemoteDataSource {
  Future<Weather> getCurrentWeather(String cityName);
}
