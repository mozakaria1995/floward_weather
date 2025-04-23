import 'package:dartz/dartz.dart';
import 'package:floward_weather/core/error/failures.dart';
import 'package:floward_weather/core/network/network_info.dart';
import 'package:floward_weather/features/weather/domain/entities/weather.dart';
import 'package:floward_weather/features/weather/domain/repositories/weather_repository.dart';

import '../datasources/weather_local_datasource.dart';
import '../datasources/weather_remote_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Weather>> getCurrentWeather() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await remoteDataSource.getCurrentWeather();
        await localDataSource.cacheWeather(remoteWeather);
        return Right(remoteWeather);
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final localWeather = await localDataSource.getLastWeather();
        return Right(localWeather);
      } catch (e) {
        return const Left(CacheFailure());
      }
    }
  }
}
