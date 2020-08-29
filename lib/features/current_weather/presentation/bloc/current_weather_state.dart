part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();

  @override
  List<Object> get props => [];
}

class CurrentWeatherInitial extends CurrentWeatherState {}

class Empty extends CurrentWeatherState {}

class Loading extends CurrentWeatherState {}

class Loaded extends CurrentWeatherState {
  final CurrentWeather currentWeather;

  Loaded({@required this.currentWeather});

  @override
  List<Object> get props => [currentWeather];
}

class Error extends CurrentWeatherState {
  final String errorMessage;

  Error({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
