import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeather {
  final WeatherRepository repository;

  GetWeather(this.repository);

  Future<Either<Failure, Weather>> execute(String cityName) async {
    return await repository.getCurrentWeather(cityName);
  }
}
