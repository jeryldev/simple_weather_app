import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/current_weather.dart';
import '../repositories/current_weather_repository.dart';

class GetCurrentWeatherCity implements UseCase<CurrentWeather, Params> {
  final CurrentWeatherRepository repository;

  GetCurrentWeatherCity(this.repository);

  @override
  Future<Either<Failure, CurrentWeather>> call(params) async {
    return await repository.getCityCurrentWeather(params.city);
  }
}

class Params extends Equatable {
  final String city;

  Params({@required this.city});

  @override
  List<Object> get props => [city];
}
