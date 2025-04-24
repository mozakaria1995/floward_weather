import 'package:dio/dio.dart';
import 'package:floward_weather/core/network/dio_helper.dart';
import 'package:floward_weather/core/utils/constants.dart';
import 'package:floward_weather/features/weather/data/datasources/weather_remote_datasource_impl.dart';
import 'package:floward_weather/features/weather/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate mock for DioHelper
@GenerateMocks([DioHelper])
import 'weather_remote_datasource_test.mocks.dart';

// Create a testable version of the data source that overrides the methods
class TestableWeatherRemoteDataSource extends WeatherRemoteDataSourceImpl {
  final MockDioHelper mockDioHelper;
  final String testApiKey;

  TestableWeatherRemoteDataSource({
    required this.mockDioHelper,
    this.testApiKey = 'test-api-key',
  });

  @override
  DioHelper getDioHelper() => mockDioHelper;

  @override
  String getApiKey() => testApiKey;
}

void main() {
  late MockDioHelper mockDioHelper;
  late TestableWeatherRemoteDataSource dataSource;

  setUp(() {
    mockDioHelper = MockDioHelper();
    dataSource = TestableWeatherRemoteDataSource(
      mockDioHelper: mockDioHelper,
    );
  });

  group('getCurrentWeather', () {
    const tWeatherModel = WeatherModel(
      cityName: 'Cairo',
      temperature: 30,
      feelsLike: 32,
      humidity: 50,
      windSpeed: 10,
      condition: 'Clear',
    );

    final tWeatherResponse = {
      'name': 'Cairo',
      'main': {
        'temp': 30.0,
        'feels_like': 32.0,
        'humidity': 50,
      },
      'wind': {
        'speed': 10.0,
      },
      'weather': [
        {
          'main': 'Clear',
        }
      ],
    };

    test('should perform a GET request with correct parameters', () async {
      // arrange
      when(mockDioHelper.getData(
        path: anyNamed('path'),
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/weather'),
            data: tWeatherResponse,
            statusCode: 200,
          ));

      // act
      await dataSource.getCurrentWeather();

      // assert
      verify(mockDioHelper.getData(
        path: '/weather',
        queryParameters: {
          'q': Constants.cityName,
          'appid': 'test-api-key',
          'units': Constants.metric,
        },
      ));
    });

    test('should return WeatherModel when the response is successful (200)',
        () async {
      // arrange
      when(mockDioHelper.getData(
        path: '/weather',
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async {
        return Response(
          requestOptions: RequestOptions(path: '/weather'),
          data: tWeatherResponse,
          statusCode: 200,
        );
      });

      // act
      final result = await dataSource.getCurrentWeather();

      // assert
      expect(result, equals(tWeatherModel));
    });

    test('should throw an Exception when the response code is not 200',
        () async {
      // arrange
      when(mockDioHelper.getData(
        path: '/weather',
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/weather'),
            statusCode: 404,
          ));

      // act
      final call = dataSource.getCurrentWeather;

      // assert
      expect(
          () => call(),
          throwsA(isA<Exception>().having((e) => e.toString(), 'message',
              'Exception: Failed to load weather data')));
    });

    test('should throw an Exception when Dio throws an error', () async {
      // arrange
      when(mockDioHelper.getData(
        path: '/weather',
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/weather'),
        error: 'Network error',
      ));

      // act
      final call = dataSource.getCurrentWeather;

      // assert
      expect(
          () => call(),
          throwsA(isA<Exception>().having((e) => e.toString(), 'message',
              'Exception: Failed to load weather data')));
    });
  });
}
