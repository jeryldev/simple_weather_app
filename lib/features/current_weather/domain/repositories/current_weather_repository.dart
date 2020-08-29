import 'package:dartz/dartz.dart';
import 'package:simple_weather_app/core/error/failure.dart';
import 'package:simple_weather_app/features/current_weather/domain/entities/current_weather.dart';

abstract class CurrentWeatherRepository {
  Future<Either<Failure, CurrentWeather>> getCityCurrentWeather(String city);
}
