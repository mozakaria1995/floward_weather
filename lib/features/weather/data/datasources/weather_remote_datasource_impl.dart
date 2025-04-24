import 'package:floward_weather/core/network/dio_helper.dart';
import 'package:floward_weather/core/utils/constants.dart';
import 'package:floward_weather/core/utils/injection_container.dart';
import 'package:floward_weather/features/weather/data/models/weather_model.dart';

import 'weather_remote_datasource.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  DioHelper getDioHelper() => sl<DioHelper>();

  // Protected method to get API key that can be overridden in tests
  String getApiKey() => Constants.apiKey;

  @override
  Future<WeatherModel> getCurrentWeather() async {
    try {
      final response = await getDioHelper().getData(
        path: '/weather',
        queryParameters: {
          'q': Constants.cityName,
          'appid': getApiKey(),
          'units': Constants.metric,
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load weather data');
    }
  }
}
