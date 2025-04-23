import 'package:floward_weather/core/utils/assets.dart';
import 'package:floward_weather/core/utils/strings.dart';
import 'package:floward_weather/features/weather/domain/usecases/get_weather.dart';
import 'package:floward_weather/features/weather/presentation/bloc/weather_event.dart';
import 'package:floward_weather/features/weather/presentation/bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeather;

  WeatherBloc({required this.getWeather}) : super(const WeatherInitial()) {
    on<GetWeatherEvent>(_onGetWeather);
  }

  Future<void> _onGetWeather(
    GetWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoading());
    final result = await getWeather(const NoParams());
    result.fold(
      (failure) => emit(WeatherError(message: failure.toString())),
      (weather) => emit(WeatherLoaded(
        weather: weather,
        animationPath: getWeatherAnimationPath(weather.condition),
      )),
    );
  }

  String getWeatherAnimationPath(String condition) {
    final weatherCondition = condition.toLowerCase();

    switch (weatherCondition) {
      case String c when c.contains(AppStrings.cloud):
        return AppAssets
            .cloudyAnimation; // Replace with cloud animation when available
      case String c when c.contains(AppStrings.clear):
        return AppAssets.sunnyAnimation;
      default:
        return AppAssets.sunnyAnimation;
    }
  }
}
