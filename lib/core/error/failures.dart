import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final List properties;

  const Failure([this.message = '', this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = '']) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = '']) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = '']) : super(message);
}
