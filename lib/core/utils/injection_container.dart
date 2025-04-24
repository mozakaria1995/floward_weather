import 'package:floward_weather/core/network/bloc/connectivity/connectivity_bloc.dart';
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
import 'package:floward_weather/features/weather/data/services/feedback_service.dart';
import 'package:floward_weather/features/weather/domain/repositories/weather_repository.dart';
import 'package:floward_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/weather/domain/usecases/get_weather.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Weather Feature
  sl.registerFactory(() => WeatherBloc(getWeather: sl()));
  sl.registerLazySingleton(() => GetWeather(sl()));
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton(() => FeedbackService());

  // Profile Feature
  sl.registerFactory(() => ProfileBloc(getProfile: sl()));
  sl.registerLazySingleton(() => GetProfile(sl()));
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      dataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<ProfileDataSource>(
    () => ProfileDataSourceImpl(),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerFactory(() => ConnectivityBloc(networkInfo: sl()));

  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
