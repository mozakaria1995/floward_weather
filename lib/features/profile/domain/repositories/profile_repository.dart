import 'package:dartz/dartz.dart';
import 'package:floward_weather/core/error/failures.dart';
import 'package:floward_weather/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile();
}
