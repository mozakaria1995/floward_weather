import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final double temperature;
  final double feelsLike;
  final double low;
  final double high;
  final String description;
  final String icon;
  final String cityName;

  const Weather({
    required this.temperature,
    required this.feelsLike,
    required this.low,
    required this.high,
    required this.description,
    required this.icon,
    required this.cityName,
  });

  @override
  List<Object> get props => [
    temperature,
    feelsLike,
    low,
    high,
    description,
    icon,
    cityName,
  ];
}
