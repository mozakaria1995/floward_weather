import 'dart:async';

import 'package:floward_weather/core/bloc/connectivity/connectivity_bloc.dart';
import 'package:floward_weather/core/bloc/connectivity/connectivity_state.dart';
import 'package:floward_weather/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:floward_weather/features/profile/presentation/bloc/profile_event.dart';
import 'package:floward_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:floward_weather/features/weather/presentation/bloc/weather_event.dart';

/// Manager class that listens to connectivity events and refreshes data when connectivity is restored
class ConnectivityManager {
  late final StreamSubscription<ConnectivityState> _connectivitySubscription;
  final WeatherBloc _weatherBloc;
  final ProfileBloc _profileBloc;
  bool _previouslyConnected = true;

  ConnectivityManager({
    required ConnectivityBloc connectivityBloc,
    required WeatherBloc weatherBloc,
    required ProfileBloc profileBloc,
  })  : _weatherBloc = weatherBloc,
        _profileBloc = profileBloc {
    _previouslyConnected = connectivityBloc.state.isConnected;

    // Listen to connectivity events
    _connectivitySubscription = connectivityBloc.stream.listen((state) {
      // Check if connection was restored
      if (!_previouslyConnected && state.isConnected) {
        _refreshData();
      }

      // Update previous connection state
      _previouslyConnected = state.isConnected;
    });
  }

  /// Refresh all data that requires internet connectivity
  void _refreshData() {
    // Refresh weather data
    _weatherBloc.add(const GetWeatherEvent());

    // Refresh profile data
    _profileBloc.add(const GetProfileEvent());
  }

  /// Clean up resources
  void dispose() {
    _connectivitySubscription.cancel();
  }
}
