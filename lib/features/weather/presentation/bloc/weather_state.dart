import 'package:equatable/equatable.dart';
import 'package:floward_weather/features/weather/domain/entities/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  final String animationPath;

  const WeatherLoaded({
    required this.weather,
    required this.animationPath,
  });

  @override
  List<Object> get props => [weather, animationPath];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError({required this.message});

  @override
  List<Object> get props => [message];
}
