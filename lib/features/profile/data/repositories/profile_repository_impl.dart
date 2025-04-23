import 'package:dartz/dartz.dart';
import 'package:floward_weather/core/error/failures.dart';
import 'package:floward_weather/core/network/network_info.dart';
import 'package:floward_weather/features/profile/data/datasources/profile_datasource.dart';
import 'package:floward_weather/features/profile/domain/entities/profile.dart';
import 'package:floward_weather/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource dataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final profile = await dataSource.getProfile();
        return Right(profile);
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
