import 'dart:async';

import 'package:floward_weather/core/network/network_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final NetworkInfo networkInfo;
  late StreamSubscription<InternetConnectionStatus> _connectionSubscription;

  ConnectivityBloc({required this.networkInfo})
      : super(const ConnectivityInitial()) {
    on<ConnectivityStatusChanged>(_onConnectivityStatusChanged);
    on<CheckConnectivity>(_onCheckConnectivity);

    // Listen to connection changes
    _connectionSubscription = InternetConnectionChecker().onStatusChange.listen(
      (status) {
        add(ConnectivityStatusChanged(
            status == InternetConnectionStatus.connected));
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
    emit(ConnectivitySuccess(isConnected));
  }

  @override
  Future<void> close() {
    _connectionSubscription.cancel();
    return super.close();
  }
}
