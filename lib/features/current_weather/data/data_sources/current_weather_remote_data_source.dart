import 'dart:convert';

import 'package:simple_weather_app/core/error/exception.dart';
import 'package:simple_weather_app/features/current_weather/data/models/current_weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class CurrentWeatherRemoteDataSource {
  /// Calls the api.openweathermap.org/data/2.5/weather?q={city} endpoint
  ///
  /// Throws a [ServerException] for all the error codes.
  Future<CurrentWeatherModel> getCityCurrentWeather(String city);
}

class CurrentWeatherRemoteDataSourceImplementation
    implements CurrentWeatherRemoteDataSource {
  final http.Client client;

  CurrentWeatherRemoteDataSourceImplementation({
    @required this.client,
  });

  @override
  Future<CurrentWeatherModel> getCityCurrentWeather(String city) async {
    return _getCurrentWeatherFromUrl(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=cd4b80ffa7a59f7415f0b8a62e2e141e');
  }

  Future<CurrentWeatherModel> _getCurrentWeatherFromUrl(String url) async {
    final response = await client.get(url, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return CurrentWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
