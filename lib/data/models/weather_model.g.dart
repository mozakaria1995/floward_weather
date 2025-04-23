// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
  temperature: (json['temperature'] as num).toDouble(),
  feelsLike: (json['feelsLike'] as num).toDouble(),
  low: (json['low'] as num).toDouble(),
  high: (json['high'] as num).toDouble(),
  description: json['description'] as String,
  icon: json['icon'] as String,
  cityName: json['cityName'] as String,
);

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'feelsLike': instance.feelsLike,
      'low': instance.low,
      'high': instance.high,
      'description': instance.description,
      'icon': instance.icon,
      'cityName': instance.cityName,
    };
