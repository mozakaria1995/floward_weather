import 'dart:async';

import 'package:floward_weather/core/network/network_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final NetworkInfo networkInfo;
  late StreamSubscription<InternetConnectionStatus> _connectionSubscription;
  bool _wasConnected = true;

  ConnectivityBloc({required this.networkInfo})
      : super(const ConnectivityInitial()) {
    on<ConnectivityStatusChanged>(_onConnectivityStatusChanged);
    on<CheckConnectivity>(_onCheckConnectivity);
    on<ConnectivityRestored>(_onConnectivityRestored);

    // Listen to connection changes
    _connectionSubscription = InternetConnectionChecker().onStatusChange.listen(
      (status) {
        final isConnected = status == InternetConnectionStatus.connected;

        // If connection was restored (was disconnected, now connected)
        if (!_wasConnected && isConnected) {
          add(ConnectivityRestored());
        }

        _wasConnected = isConnected;
        add(ConnectivityStatusChanged(isConnected));
      },
    );
  }

  void _onConnectivityStatusChanged(
    ConnectivityStatusChanged event,
    Emitter<ConnectivityState> emit,
  ) {
    emit(ConnectivitySuccess(event.isConnected));
  }

  Future<void> _onCheckConnectivity(
    CheckConnectivity event,
    Emitter<ConnectivityState> emit,
  ) async {
    final isConnected = await networkInfo.isConnected;
    _wasConnected = isConnected;
    emit(ConnectivitySuccess(isConnected));
  }

  void _onConnectivityRestored(
    ConnectivityRestored event,
    Emitter<ConnectivityState> emit,
  ) {
    // This event doesn't change the state but will be listened to
    // by other parts of the app to refresh data
  }

  @override
  Future<void> close() {
    _connectionSubscription.cancel();
    return super.close();
  }
}
