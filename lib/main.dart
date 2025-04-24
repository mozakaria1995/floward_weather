import 'dart:developer' as developer;

import 'package:floward_weather/config/flavor_config.dart';
import 'package:floward_weather/core/bloc/connectivity/connectivity_bloc.dart';
import 'package:floward_weather/core/bloc/connectivity/connectivity_event.dart';
import 'package:floward_weather/core/network/dio_helper.dart';
import 'package:floward_weather/core/utils/theme.dart';
import 'package:floward_weather/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:floward_weather/features/profile/presentation/bloc/profile_event.dart';
import 'package:floward_weather/features/weather/presentation/bloc/weather_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  // Initialize DioHelper
  DioHelper.init();

  // Test method channel
  try {
    const profileChannel = MethodChannel('com.floward.weather/profile');
    final result = await profileChannel.invokeMethod<dynamic>('getProfileData');
    developer
        .log('Test method channel result: $result (${result.runtimeType})');

    if (result is Map) {
      final map = Map<String, dynamic>.from(result);
      developer.log('Test method channel result as map: $map');

      // Check expected keys
      final expectedKeys = [
        'name',
        'email',
        'location',
        'member_since',
        'avatar_url'
      ];
      for (final key in expectedKeys) {
        developer.log(
            'Test method channel - key "$key": ${map.containsKey(key)}, value: ${map[key]}');
      }
    }
  } catch (e) {
    developer.log('Test method channel error: $e', error: e);
  }

  await di.init();
  FlavorConfig.instance.flavor = Flavor.dev; // Set the initial flavor
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      child: MaterialApp(
        title: 'Floward Weather',
        theme: AppTheme.themeData,
        home: const MainPage(),
      ),
    );
  }
}
