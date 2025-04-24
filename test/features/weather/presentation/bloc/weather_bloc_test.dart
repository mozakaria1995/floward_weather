import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:floward_weather/core/error/failures.dart';
import 'package:floward_weather/core/utils/assets.dart';
import 'package:floward_weather/features/weather/domain/entities/weather.dart';
import 'package:floward_weather/features/weather/domain/usecases/get_weather.dart';
import 'package:floward_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:floward_weather/features/weather/presentation/bloc/weather_event.dart';
import 'package:floward_weather/features/weather/presentation/bloc/weather_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([GetWeather])
import 'weather_bloc_test.mocks.dart';

void main() {
  late WeatherBloc bloc;
  late MockGetWeather mockGetWeather;

  setUp(() {
    mockGetWeather = MockGetWeather();
    bloc = WeatherBloc(getWeather: mockGetWeather);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be WeatherInitial', () {
    // assert
    expect(bloc.state, const WeatherInitial());
  });

  group('GetWeatherEvent', () {
    const tWeather = Weather(
      cityName: 'Cairo',
      temperature: 30,
      feelsLike: 32,
      humidity: 50,
      windSpeed: 10,
      condition: 'Clear',
    );

    const tWeatherCloudy = Weather(
      cityName: 'Cairo',
      temperature: 25,
      feelsLike: 24,
      humidity: 60,
      windSpeed: 8,
      condition: 'Clouds',
    );

    blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully with Clear condition',
      build: () {
        when(mockGetWeather(any))
            .thenAnswer((_) async => const Right(tWeather));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetWeatherEvent()),
      expect: () => [
        const WeatherLoading(),
        const WeatherLoaded(
          weather: tWeather,
          animationPath: AppAssets.sunnyAnimation,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWeather(const NoParams()));
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully with Clouds condition',
      build: () {
        when(mockGetWeather(any))
            .thenAnswer((_) async => const Right(tWeatherCloudy));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetWeatherEvent()),
      expect: () => [
        const WeatherLoading(),
        const WeatherLoaded(
          weather: tWeatherCloudy,
          animationPath: AppAssets.cloudyAnimation,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWeather(const NoParams()));
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherError] when getting data fails',
      build: () {
        when(mockGetWeather(any)).thenAnswer(
            (_) async => const Left(ServerFailure('Error occurred')));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetWeatherEvent()),
      expect: () => [
        const WeatherLoading(),
        WeatherError(message: const ServerFailure('Error occurred').toString()),
      ],
      verify: (bloc) {
        verify(mockGetWeather(const NoParams()));
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherError] with default error when no message provided',
      build: () {
        when(mockGetWeather(any))
            .thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetWeatherEvent()),
      expect: () => [
        const WeatherLoading(),
        WeatherError(message: const ServerFailure().toString()),
      ],
      verify: (bloc) {
        verify(mockGetWeather(const NoParams()));
      },
    );
  });

  group('getWeatherAnimationPath', () {
    test('should return sunny animation path for "Clear" condition', () {
      // arrange
      const condition = 'Clear';

      // act
      final result = bloc.getWeatherAnimationPath(condition);

      // assert
      expect(result, AppAssets.sunnyAnimation);
    });

    test('should return cloudy animation path for "Clouds" condition', () {
      // arrange
      const condition = 'Clouds';

      // act
      final result = bloc.getWeatherAnimationPath(condition);

      // assert
      expect(result, AppAssets.cloudyAnimation);
    });

    test('should return sunny animation path for unknown condition', () {
      // arrange
      const condition = 'Unknown';

      // act
      final result = bloc.getWeatherAnimationPath(condition);

      // assert
      expect(result, AppAssets.sunnyAnimation);
    });

    test('should be case insensitive when checking weather condition', () {
      // arrange
      const condition = 'cLouDs';

      // act
      final result = bloc.getWeatherAnimationPath(condition);

      // assert
      expect(result, AppAssets.cloudyAnimation);
    });
  });
}
