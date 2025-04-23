import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_weather.dart' as usecase;
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final usecase.GetWeather getWeather;

  WeatherBloc({required this.getWeather}) : super(WeatherEmpty()) {
    on<GetWeather>((event, emit) async {
      emit(WeatherLoading());
      final result = await getWeather.execute(event.cityName);
      result.fold(
        (failure) => emit(WeatherError(failure.message)),
        (weather) => emit(WeatherLoaded(weather)),
      );
    });
  }
}
