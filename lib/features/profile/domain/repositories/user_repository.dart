import 'package:dartz/dartz.dart';
import 'package:floward_weather/core/error/failures.dart';

import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, void>> updateUser(User user);
}
