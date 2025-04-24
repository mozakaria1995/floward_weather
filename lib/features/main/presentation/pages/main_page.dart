import 'package:floward_weather/core/network/bloc/connectivity/connectivity_bloc.dart';
import 'package:floward_weather/core/network/bloc/connectivity/connectivity_event.dart';
import 'package:floward_weather/core/network/bloc/connectivity/connectivity_state.dart';
import 'package:floward_weather/core/utils/strings.dart';
import 'package:floward_weather/core/widgets/connectivity_banner.dart';
import 'package:floward_weather/features/profile/presentation/pages/profile_page.dart';
import 'package:floward_weather/features/weather/presentation/pages/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/navigation/navigation_bloc.dart';
import '../bloc/navigation/navigation_event.dart';
import '../bloc/navigation/navigation_state.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, navigationState) {
        return BlocBuilder<ConnectivityBloc, ConnectivityState>(
          builder: (context, connectivityState) {
            return Scaffold(
              body: Column(
                children: [
                  // Display connectivity banner
                  ConnectivityBanner(
                    isConnected: connectivityState.isConnected,
                    onRetry: () => context
                        .read<ConnectivityBloc>()
                        .add(CheckConnectivity()),
                  ),
                  // Main content
                  Expanded(
                    child: IndexedStack(
                      index: navigationState.index,
                      children: const [WeatherPage(), ProfilePage()],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: navigationState.index,
                onTap: (index) {
                  context
                      .read<NavigationBloc>()
                      .add(NavigationTabChanged(index));
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.cloud),
                    label: AppStrings.weather,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: AppStrings.profile,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
