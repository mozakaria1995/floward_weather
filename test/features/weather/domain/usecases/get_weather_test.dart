import 'package:dartz/dartz.dart';
import 'package:floward_weather/core/error/failures.dart';
import 'package:floward_weather/features/weather/domain/entities/weather.dart';
import 'package:floward_weather/features/weather/domain/repositories/weather_repository.dart';
import 'package:floward_weather/features/weather/domain/usecases/get_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_weather_test.mocks.dart';

// Manual mock for WeatherRepository
@GenerateMocks([WeatherRepository])
void main() {
  late GetWeather useCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    useCase = GetWeather(mockWeatherRepository);
  });

  const testWeather = Weather(
    cityName: 'London',
    temperature: 20.5,
    feelsLike: 19.2,
    humidity: 65,
    windSpeed: 5.2,
    condition: 'Clear',
  );

  test(
    'should get weather data from the repository',
    () async {
      // arrange
      when(mockWeatherRepository.getCurrentWeather())
          .thenAnswer((_) async => const Right(testWeather));

      // act
      final result = await useCase(const NoParams());

      // assert
      expect(result, const Right(testWeather));
      verify(mockWeatherRepository.getCurrentWeather());
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );

  test(
    'should return server failure when there is a server error',
    () async {
      // arrange
      const failure = ServerFailure('Server error');
      when(mockWeatherRepository.getCurrentWeather())
          .thenAnswer((_) async => const Left(failure));

      // act
      final result = await useCase(const NoParams());

      // assert
      expect(result, const Left(failure));
      verify(mockWeatherRepository.getCurrentWeather());
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );

  test(
    'should return cache failure when there is a cache error',
    () async {
      // arrange
      const failure = CacheFailure('Cache error');
      when(mockWeatherRepository.getCurrentWeather())
          .thenAnswer((_) async => const Left(failure));

      // act
      final result = await useCase(const NoParams());

      // assert
      expect(result, const Left(failure));
      verify(mockWeatherRepository.getCurrentWeather());
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );

  test(
    'should return network failure when there is a network error',
    () async {
      // arrange
      const failure = NetworkFailure('Network error');
      when(mockWeatherRepository.getCurrentWeather())
          .thenAnswer((_) async => const Left(failure));

      // act
      final result = await useCase(const NoParams());

      // assert
      expect(result, const Left(failure));
      verify(mockWeatherRepository.getCurrentWeather());
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );
}
