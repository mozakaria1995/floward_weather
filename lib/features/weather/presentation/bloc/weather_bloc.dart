import 'package:floward_weather/features/weather/domain/usecases/get_weather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeather;

  WeatherBloc({required this.getWeather}) : super(WeatherEmpty()) {
    on<GetWeatherEvent>((event, emit) async {
      emit(WeatherLoading());
      final result = await getWeather.execute(event.cityName);
      result.fold(
        (failure) => emit(WeatherError(failure.message)),
        (weather) => emit(WeatherLoaded(weather)),
      );
    });
  }
}
