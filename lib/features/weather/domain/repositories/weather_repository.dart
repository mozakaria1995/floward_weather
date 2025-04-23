import 'package:dartz/dartz.dart';
import 'package:floward_weather/core/error/failures.dart';
import 'package:floward_weather/features/weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather();
}
