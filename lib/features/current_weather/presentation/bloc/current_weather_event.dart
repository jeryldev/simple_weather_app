part of 'current_weather_bloc.dart';

abstract class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentWeatherForCity extends CurrentWeatherEvent {
  final String city;

  GetCurrentWeatherForCity({@required this.city});

  @override
  List<Object> get props => [city];
}
