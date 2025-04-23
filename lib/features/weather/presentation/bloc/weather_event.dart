import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeatherEvent extends WeatherEvent {
  final String cityName;

  const GetWeatherEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}
