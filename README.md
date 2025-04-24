# 🌦️ Floward Weather App

> A stunning Flutter weather application showcasing clean architecture, native module integration, and modern UI/UX patterns.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

## 📱 Preview

<!-- Add app screenshots here when available -->

## 🏗️ Project Structure

The project follows **clean architecture** principles with the following structure:

```
lib/
├── core/
│   ├── bloc/
│   │   └── connectivity/        # Connectivity bloc for network monitoring
│   ├── connectivity/            # Network connectivity management
│   ├── error/                   # Error handling (failures)
│   ├── network/                 # Network information interface
│   └── utils/                   # Common utilities and constants
├── features/
│   └── weather/
│       ├── data/
│       │   ├── datasources/     # Remote and local data sources
│       │   ├── models/          # Data models
│       │   └── repositories/    # Repository implementations
│       ├── domain/
│       │   ├── entities/        # Domain entities
│       │   ├── repositories/    # Repository interfaces
│       │   └── usecases/        # Business logic use cases
│       └── presentation/
│           ├── bloc/            # State management
│           ├── pages/           # UI pages
│           └── widgets/         # Reusable UI components
└── main.dart                    # Application entry point
```

## 🔌 Native Module Integration

The app demonstrates the integration of native modules for enhanced functionality:

### 🤖 Android Integration
- Custom Android modules are implemented in `android/app/src/main/kotlin/`
- Separate build configurations for development and production environments
- Custom channel methods for platform-specific functionality

### 🍎 iOS Integration
- Native Swift modules located in `ios/Runner/`
- Method channel implementation for communication between Flutter and iOS
- Environment-specific configurations

## ✨ Key Features

### 🌡️ Weather Data Handling
- Fetches weather data from a remote API
- Displays current weather conditions with appropriate animations
- Shows detailed weather information (temperature, humidity, wind speed)

### 💾 Smart Caching Mechanism
- Local caching of the last fetched weather data using SharedPreferences
- Persistence across app restarts
- Automatic fallback to cached data when offline
- Time-based cache invalidation strategy

### 📶 Network Connectivity
- Real-time network connectivity monitoring
- User-friendly notifications for connectivity changes
- Graceful handling of offline mode with seamless transition to cached data
- Toast messages when network status changes

### 🎭 Lottie Animations
- Dynamic weather animations based on current conditions
- Different animations for sunny, rainy, cloudy, stormy, and snowy conditions
- Smooth transitions between different weather states
- Optimized animation assets for performance
- Located in `assets/animations/` directory

## 🧠 Implementation Decisions

### 🧩 Clean Architecture
- Separation of concerns with distinct layers
- Domain-driven design for business logic
- Dependency injection for testability

### 🔄 State Management
- BLoC pattern for reactive state management
- Event-driven architecture
- Clear separation between UI and business logic

### 🧪 Comprehensive Testing Strategy
- **Unit Tests:** Tests for each layer including repositories, use cases, and BLoCs
- **Repository Testing:** Tests for proper data source selection based on network availability
- **Use Case Testing:** Tests for business logic in isolation from UI
- **BLoC Testing:** Tests for state transitions and event handling
- **Mock Implementation:** Using Mockito for dependency mocking
- **Test Coverage:** Aiming for high test coverage across all layers
- **Continuous Integration:** Tests run on GitHub Actions for every PR

### ⚡ Performance Optimizations
- Minimized widget rebuilds
- Efficient data caching
- Lazy loading of resources

## 🚀 Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Choose the appropriate build flavor:
   - Development: `flutter run --flavor dev -t lib/main_dev.dart`
   - Production: `flutter run --flavor prod -t lib/main_prod.dart`

## 📝 Examples

### 🔀 Differentiating Between Environments

```dart
// Development vs Production API endpoints
class ApiConstants {
  static const String baseUrl = flavor == Flavor.dev 
    ? 'https://dev-api.example.com' 
    : 'https://api.example.com';
}
```

### ☁️ Using the Weather Feature

```dart
// Example of weather data retrieval
final weatherBloc = context.read<WeatherBloc>();
weatherBloc.add(const GetWeatherEvent());

// Display weather data
BlocBuilder<WeatherBloc, WeatherState>(
  builder: (context, state) {
    if (state is WeatherLoaded) {
      return WeatherDisplay(weather: state.weather);
    } else if (state is WeatherLoading) {
      return const LoadingIndicator();
    } else if (state is WeatherError) {
      return ErrorMessage(message: state.message);
    }
    return const SizedBox.shrink();
  },
)
```

### 📡 Network Connectivity Monitoring

```dart
// Listening to network changes
BlocBuilder<ConnectivityBloc, ConnectivityState>(
  builder: (context, state) {
    if (state is ConnectivityConnected) {
      return Container(
        color: Colors.green,
        child: Text('Online - Fetching fresh data'),
      );
    } else if (state is ConnectivityDisconnected) {
      return Container(
        color: Colors.amber,
        child: Text('Offline - Using cached data'),
      );
    }
    return const SizedBox.shrink();
  },
)
```

### 💾 Utilizing Cached Weather Data

```dart
// Example of retrieving cached weather data
Future<Weather?> getLastCachedWeather() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? weatherJson = prefs.getString('last_weather');
  
  if (weatherJson != null) {
    return WeatherModel.fromJson(json.decode(weatherJson));
  }
  return null;
}
```

### 🎭 Implementing Lottie Animations

```dart
// Choosing the right animation based on weather condition
Widget getWeatherAnimation(String condition) {
  String animationPath;
  
  switch (condition.toLowerCase()) {
    case 'sunny':
    case 'clear':
      animationPath = 'assets/animations/sunny.json';
      break;
    case 'rainy':
    case 'rain':
      animationPath = 'assets/animations/rainy.json';
      break;
    case 'cloudy':
    case 'clouds':
      animationPath = 'assets/animations/cloudy.json';
      break;
    // Other conditions...
    default:
      animationPath = 'assets/animations/default.json';
  }
  
  return Lottie.asset(
    animationPath,
    width: 200,
    height: 200,
    fit: BoxFit.fill,
  );
}
```
