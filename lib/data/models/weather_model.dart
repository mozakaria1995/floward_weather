import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/weather.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel extends Weather {
  const WeatherModel({
    required super.temperature,
    required super.feelsLike,
    required super.low,
    required super.high,
    required super.description,
    required super.icon,
    required super.cityName,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];

    return WeatherModel(
      temperature: (main['temp'] as num).toDouble(),
      feelsLike: (main['feels_like'] as num).toDouble(),
      low: (main['temp_min'] as num).toDouble(),
      high: (main['temp_max'] as num).toDouble(),
      description: weather['description'],
      icon: weather['icon'],
      cityName: json['name'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'main': {
      'temp': temperature,
      'feels_like': feelsLike,
      'temp_min': low,
      'temp_max': high,
    },
    'weather': [
      {'description': description, 'icon': icon},
    ],
    'name': cityName,
  };
}
