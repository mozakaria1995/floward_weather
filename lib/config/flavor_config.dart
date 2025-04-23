import 'package:floward_weather/config/flavors.dart';

class FlavorConfig {
  static final FlavorConfig _instance = FlavorConfig._internal();
  factory FlavorConfig() => _instance;
  FlavorConfig._internal();

  Flavor flavor = Flavor.dev;

  static FlavorConfig get instance => _instance;
}
