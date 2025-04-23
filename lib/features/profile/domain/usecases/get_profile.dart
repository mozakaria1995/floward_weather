import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:floward_weather/core/error/failures.dart';
import 'package:floward_weather/features/profile/domain/entities/profile.dart';
import 'package:floward_weather/features/profile/domain/repositories/profile_repository.dart';

class GetProfile {
  final ProfileRepository repository;

  GetProfile(this.repository);

  Future<Either<Failure, Profile>> call(NoParams params) async {
    return await repository.getProfile();
  }
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
