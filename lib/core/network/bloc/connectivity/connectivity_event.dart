import 'package:equatable/equatable.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}

class ConnectivityStatusChanged extends ConnectivityEvent {
  final bool isConnected;

  const ConnectivityStatusChanged(this.isConnected);

  @override
  List<Object> get props => [isConnected];
}

class CheckConnectivity extends ConnectivityEvent {}

class ConnectivityRestored extends ConnectivityEvent {}
