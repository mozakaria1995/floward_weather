import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final List properties;

  const Failure([this.message = '', this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [message, properties];

  @override
  String toString() {
    return message.isNotEmpty ? message : runtimeType.toString();
  }
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error occurred'])
      : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Failed to retrieve cached data'])
      : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'No internet connection'])
      : super(message);
}
