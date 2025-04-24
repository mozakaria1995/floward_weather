import 'package:floward_weather/config/flavor_config.dart';
import 'package:floward_weather/core/network/bloc/connectivity/connectivity_bloc.dart';
import 'package:floward_weather/core/network/bloc/connectivity/connectivity_event.dart';
import 'package:floward_weather/core/network/connectivity_manager.dart';
import 'package:floward_weather/core/utils/theme.dart';
import 'package:floward_weather/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:floward_weather/features/profile/presentation/bloc/profile_event.dart';
import 'package:floward_weather/features/weather/presentation/bloc/weather_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config/flavors.dart';
import 'core/utils/injection_container.dart' as di;
import 'features/main/presentation/bloc/navigation/navigation_bloc.dart';
import 'features/main/presentation/pages/main_page.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables based on flavor
  await dotenv.load(
      fileName: "assets/env/.env.${FlavorConfig.instance.flavor.name}");

  await di.init();
  FlavorConfig.instance.flavor = Flavor.dev; // Set the initial flavor
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityManager? _connectivityManager;

  @override
  void dispose() {
    _connectivityManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(
          create: (context) =>
              WeatherBloc(getWeather: di.sl())..add(const GetWeatherEvent()),
        ),
        BlocProvider(
          create: (context) =>
              ProfileBloc(getProfile: di.sl())..add(const GetProfileEvent()),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<ConnectivityBloc>()..add(CheckConnectivity()),
        ),
      ],
      child: Builder(builder: (context) {
        // Initialize the ConnectivityManager with the BLoCs from context
        _connectivityManager ??= ConnectivityManager(
          connectivityBloc: context.read<ConnectivityBloc>(),
          weatherBloc: context.read<WeatherBloc>(),
          profileBloc: context.read<ProfileBloc>(),
        );

        return MaterialApp(
          title: 'Floward Weather',
          theme: AppTheme.themeData,
          home: const MainPage(),
        );
      }),
    );
  }
}
