import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather_app/core/error/exception.dart';
import 'package:simple_weather_app/features/current_weather/data/models/current_weather_model.dart';
import 'package:meta/meta.dart';

abstract class CurrentWeatherLocalDataSource {
  /// Gets the cached [CurrentWeatherModel] which was gotten the last time
  /// the user had internet connection
  ///
  /// Throws [CacheException] if no cached data is present
  Future<CurrentWeatherModel> getLastCityCurrentWeather();

  /// Cache the [CurrentWeatherModel] which was gotten the last time
  /// before the user lost the internet connection
  ///
  /// Throws [CacheException] if cannot cache data.
  Future<void> cacheCityCurrentWeather(
      CurrentWeatherModel cityCurrentWeatherToCache);
}

const CACHED_CITY_CURRENT_WEATHER = 'CACHED_CITY_CURRENT_WEATHER';

class CurrentWeatherLocalDataSourceImplementation
    implements CurrentWeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  CurrentWeatherLocalDataSourceImplementation(
      {@required this.sharedPreferences});

  @override
  Future<void> cacheCityCurrentWeather(
      CurrentWeatherModel cityCurrentWeatherToCache) {
    return sharedPreferences.setString(
      CACHED_CITY_CURRENT_WEATHER,
      json.encode(cityCurrentWeatherToCache.toJson()),
    );
  }

  @override
  Future<CurrentWeatherModel> getLastCityCurrentWeather() {
    final jsonString = sharedPreferences.getString(CACHED_CITY_CURRENT_WEATHER);
    if (jsonString != null) {
      return Future.value(
          CurrentWeatherModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
