part of 'current_weather_bloc.dart';

abstract class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentWeatherForCityEvent extends CurrentWeatherEvent {
  final String city;

  GetCurrentWeatherForCityEvent(this.city);

  @override
  List<Object> get props => [city];
}
