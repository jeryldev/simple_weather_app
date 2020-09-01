import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_weather_app/core/error/failure.dart';
import 'package:simple_weather_app/features/current_weather/domain/entities/current_weather.dart';
import 'package:meta/meta.dart';
import 'package:simple_weather_app/features/current_weather/domain/usecases/get_current_weather_city.dart';
part 'current_weather_event.dart';
part 'current_weather_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server failure';
const CACHE_FAILURE_MESSAGE = 'Cache failure';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final GetCurrentWeatherCity getCurrentWeatherCity;

  CurrentWeatherBloc({@required GetCurrentWeatherCity cityString})
      : assert(cityString != null),
        getCurrentWeatherCity = cityString,
        super(Empty());
  // CurrentWeatherBloc() : super(CurrentWeatherInitial());

  @override
  Stream<CurrentWeatherState> mapEventToState(
    CurrentWeatherEvent event,
  ) async* {
    if (event is GetCurrentWeatherForCityEvent) {
      final inputCityName = event.city;
      yield Loading();
      final failureOrCity =
          await getCurrentWeatherCity(Params(city: inputCityName));
      yield failureOrCity.fold(
        (failure) => Error(errorMessage: _mapFailureToMessage(failure)),
        (cityCurrentWeather) => Loaded(currentWeather: cityCurrentWeather),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
        break;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
        break;
      default:
        return 'Unexpected error';
    }
  }
}
