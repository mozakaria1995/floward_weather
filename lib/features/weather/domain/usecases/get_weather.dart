import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:floward_weather/core/error/failures.dart';
import 'package:floward_weather/features/weather/domain/entities/weather.dart';
import 'package:floward_weather/features/weather/domain/repositories/weather_repository.dart';

class GetWeather {
  final WeatherRepository repository;

  GetWeather(this.repository);

  Future<Either<Failure, Weather>> call(NoParams params) async {
    return await repository.getCurrentWeather();
  }
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
