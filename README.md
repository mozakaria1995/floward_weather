# 🌦️ Floward Weather App

> A Flutter weather application showcasing clean architecture, BLoC pattern, and modern UI design.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

## 🏗️ Project Structure

The project follows **clean architecture** principles with the following structure:

```
lib/
├── core/
│   ├── bloc/
│   │   └── connectivity/        # Connectivity bloc for network monitoring
│   ├── network/                 # Network information interface
│   ├── error/                   # Error handling (failures)
│   ├── widgets/                 # Shared UI components
│   └── utils/                   # Common utilities and constants
├── features/
│   ├── weather/
│   │   ├── data/
│   │   │   ├── datasources/     # Remote and local data sources
│   │   │   ├── models/          # Data models
│   │   │   └── repositories/    # Repository implementations
│   │   ├── domain/
│   │   │   ├── entities/        # Domain entities
│   │   │   ├── repositories/    # Repository interfaces
│   │   │   └── usecases/        # Business logic use cases
│   │   └── presentation/
│   │       ├── bloc/            # State management
│   │       ├── pages/           # UI pages
│   │       └── widgets/         # Reusable UI components
│   ├── main/                    # Main app navigation
│   └── profile/                 # User profile (if implemented)
└── main.dart                    # Application entry point
```

## ✨ Implemented Features

### 🌡️ Weather Data Handling
- Fetches weather data from a remote API
- Displays current weather conditions with animations
- Shows detailed weather information (temperature, humidity, wind speed)

### 💾 Local Caching
- Uses SharedPreferences to cache the last fetched weather data
- Persists weather information across app restarts
- Serves as a fallback when offline

### 📶 Network Connectivity Monitoring
- Real-time network connectivity monitoring using ConnectivityBloc
- Notifies user of connectivity changes
- Handles offline mode by using cached data

### 🎭 Simple Lottie Animations
- Uses Lottie animations for weather conditions
- Includes animations for cloud and sun conditions
- Enhances visual appeal of the weather display

### 🔌 Native Module Integration
- Fetches user data from platform-specific native modules
- Displays operating system information in the user profile
- Implements feedback submission through native modules
- Platform-channel communication for seamless native-Flutter interaction

#### Profile Section
- Displays operating system type retrieved from native code
- Presents device-specific information using platform channels
- Displays mock user data (name, email, preferences) retrieved from native modules

#### Feedback Submission
- Dashboard contains a feedback submission button
- Submits user feedback directly to native modules

## 🧠 Implementation Approach

### 🧩 Clean Architecture
- Separation of concerns with distinct layers
- Domain-driven design for business logic
- Dependency injection using get_it

### 🔄 State Management
- BLoC pattern for reactive state management
- Event-driven architecture
- Clear separation between UI and business logic

### 🧪 Testing Setup
- Test directories organized by feature and layer
- Unit tests for the domain layer
- Uses mockito for dependency mocking

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (2.10.0 or higher)
- Dart SDK (2.16.0 or higher)
- Android Studio / XCode for native development
- An OpenWeather API key (for weather data)

### Installation
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run with `flutter run`
