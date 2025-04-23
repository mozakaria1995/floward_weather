import 'package:floward_weather/core/network/network_info.dart';
import 'package:floward_weather/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:floward_weather/features/weather/data/datasources/weather_local_datasource_impl.dart';
import 'package:floward_weather/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:floward_weather/features/weather/data/datasources/weather_remote_datasource_impl.dart';
import 'package:floward_weather/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:floward_weather/features/weather/domain/repositories/weather_repository.dart';
import 'package:floward_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/weather/domain/usecases/get_weather.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Weather
  // Bloc
  sl.registerFactory(() => WeatherBloc(getWeather: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetWeather(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
