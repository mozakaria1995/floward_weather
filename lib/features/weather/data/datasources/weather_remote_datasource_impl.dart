import 'package:floward_weather/core/network/dio_helper.dart';
import 'package:floward_weather/core/utils/constants.dart';
import 'package:floward_weather/features/weather/data/models/weather_model.dart';

import 'weather_remote_datasource.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  WeatherRemoteDataSourceImpl();

  @override
  Future<WeatherModel> getCurrentWeather() async {
    try {
      final response = await DioHelper.getData(
        url: '/weather',
        query: {
          'q': Constants.cityName,
          'appid': Constants.apiKey,
          'units': Constants.metric,
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load weather data');
    }
  }
}
