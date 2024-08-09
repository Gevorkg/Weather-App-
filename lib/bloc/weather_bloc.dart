// ignore_for_file: unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherFetchEvent>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        WeatherFactory wf = WeatherFactory('8e442787ac3c9719d6b6c1b8774a8d6f',
            language: Language.ENGLISH);

        Weather weather = await wf.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
        emit(WeatherSuccessState(weather: weather));
      } catch (e) {
        emit(WeatherFailureState());
      }
    });
  }
}
