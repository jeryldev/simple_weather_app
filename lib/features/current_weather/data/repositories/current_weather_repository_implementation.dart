import 'package:simple_weather_app/core/error/exception.dart';
import 'package:simple_weather_app/core/network/network_info.dart';
import 'package:simple_weather_app/features/current_weather/data/data_sources/current_weather_local_data_source.dart';
import 'package:simple_weather_app/features/current_weather/data/data_sources/current_weather_remote_data_source.dart';
import 'package:simple_weather_app/features/current_weather/domain/entities/current_weather.dart';
import 'package:simple_weather_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:simple_weather_app/features/current_weather/domain/repositories/current_weather_repository.dart';
import 'package:flutter/foundation.dart';

class CurrentWeatherRepositoryImplementation extends CurrentWeatherRepository {
  final CurrentWeatherRemoteDataSource remoteDataSource;
  final CurrentWeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CurrentWeatherRepositoryImplementation({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, CurrentWeather>> getCityCurrentWeather(
      String city) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCityCurrentWeather =
            await remoteDataSource.getCityCurrentWeather(city);
        localDataSource.cacheCityCurrentWeather(remoteCityCurrentWeather);
        return Right(remoteCityCurrentWeather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCityCurrentWeather =
            await localDataSource.getLastCityCurrentWeather();
        return Right(localCityCurrentWeather);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
