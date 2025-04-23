import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static const cityName = 'Cairo,EG';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static const metric = 'metric';
}
