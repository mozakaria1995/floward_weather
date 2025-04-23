import '../../domain/entities/weather.dart';

abstract class WeatherLocalDataSource {
  Future<Weather> getLastWeather();
  Future<void> cacheWeather(Weather weather);
}
