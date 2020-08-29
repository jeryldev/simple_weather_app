import 'package:flutter/foundation.dart';
import 'package:simple_weather_app/features/current_weather/domain/entities/current_weather.dart';

class CurrentWeatherModel extends CurrentWeather {
  CurrentWeatherModel({
    @required String name,
    Main main,
    List<Weather> weather,
    Sys sys,
  }) : super(name: name, main: main, weather: weather, sys: sys);

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    var list = json['weather'] as List;
    List<Weather> weatherList = list.map((e) => Weather.fromJson(e)).toList();
    return CurrentWeatherModel(
      name: json['name'],
      main: Main.fromJson(json['main']),
      weather: weatherList,
      sys: Sys.fromJson(json['sys']),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> weatherList = this.weather != null
        ? this.weather.map((e) => e.toJson()).toList()
        : null;
    return {
      'name': name,
      'main': main.toJson(),
      'weather': weatherList,
      'sys': sys.toJson()
    };
  }
}
