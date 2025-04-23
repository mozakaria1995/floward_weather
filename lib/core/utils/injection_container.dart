import 'package:floward_weather/core/bloc/connectivity/connectivity_bloc.dart';
import 'package:floward_weather/core/network/network_info.dart';
import 'package:floward_weather/features/profile/data/datasources/profile_datasource.dart';
import 'package:floward_weather/features/profile/data/datasources/profile_datasource_impl.dart';
import 'package:floward_weather/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:floward_weather/features/profile/domain/repositories/profile_repository.dart';
import 'package:floward_weather/features/profile/domain/usecases/get_profile.dart';
import 'package:floward_weather/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:floward_weather/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:floward_weather/features/weather/data/datasources/weather_local_datasource_impl.dart';
import 'package:floward_weather/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:floward_weather/features/weather/data/datasources/weather_remote_datasource_impl.dart';
import 'package:floward_weather/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:floward_weather/features/weather/domain/repositories/weather_repository.dart';
import 'package:floward_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/weather/domain/usecases/get_weather.dart';

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
    () => WeatherRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Profile
  // Bloc
  sl.registerFactory(() => ProfileBloc(getProfile: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetProfile(sl()));

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      dataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProfileDataSource>(
    () => ProfileDataSourceImpl(),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Connectivity Bloc
  sl.registerFactory(() => ConnectivityBloc(networkInfo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
