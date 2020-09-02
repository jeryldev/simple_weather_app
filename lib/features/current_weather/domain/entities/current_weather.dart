import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class CurrentWeather extends Equatable {
  final String name;
  final Main main;
  final List<Weather> weather;
  final Sys sys;

  CurrentWeather({
    @required this.name,
    this.main,
    this.weather,
    this.sys,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    var list = json['weather'] as List;
    List<Weather> weatherList = list.map((e) => Weather.fromJson(e)).toList();

    return CurrentWeather(
      name: json['name'],
      main: Main.fromJson(json['main']),
      sys: Sys.fromJson(json['sys']),
      weather: weatherList,
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

  @override
  List<Object> get props => [main, weather, name, sys];
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['description'],
      icon: json['icon'],
      main: json['main'],
      id: (json['id'] as num)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'description': description, 'icon': icon, 'main': main, 'id': id};
  }

  // Override the == operator
  @override
  bool operator ==(o) =>
      o is Weather &&
      description == o.description &&
      icon == o.icon &&
      main == o.main &&
      id == o.id;

  // Override the get hashcode method
  @override
  int get hashCode =>
      description.hashCode ^ icon.hashCode ^ main.hashCode ^ id.hashCode;
}

class Main {
  final double temp;
  final double pressure;
  final double humidity;
  // ignore: non_constant_identifier_names
  final double temp_min;
  // ignore: non_constant_identifier_names
  final double temp_max;

  // ignore: non_constant_identifier_names
  Main({this.temp, this.pressure, this.humidity, this.temp_min, this.temp_max});

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      humidity: (json['humidity'] as num).toDouble(),
      pressure: (json['pressure'] as num).toDouble(),
      temp: (json['temp'] as num)?.toDouble(),
      temp_max: (json['temp_max'] as num)?.toDouble(),
      temp_min: (json['temp_min'] as num)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'humidity': humidity,
      'pressure': pressure,
      'temp': temp,
      'temp_min': temp_min,
      'temp_max': temp_max
    };
  }

  // Override the == operator
  @override
  bool operator ==(o) =>
      o is Main &&
      humidity == o.humidity &&
      pressure == o.pressure &&
      temp == o.temp &&
      temp_min == o.temp_min &&
      temp_max == o.temp_max;

  // Override the get hashcode method
  @override
  int get hashCode =>
      humidity.hashCode ^
      pressure.hashCode ^
      temp.hashCode ^
      temp_min.hashCode ^
      temp_max.hashCode;
}

class Sys {
  final int type;
  final int id;
  final double message;
  final String country;
  final int sunrise;
  final int sunset;

  Sys(
      {this.type,
      this.id,
      this.message,
      this.country,
      this.sunrise,
      this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      country: json['country'],
      id: (json['id'] as num)?.toInt(),
      message: (json['message'] as num)?.toDouble(),
      sunrise: (json['sunrise'] as num)?.toInt(),
      sunset: (json['sunset'] as num)?.toInt(),
      type: (json['type'] as num)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'id': id,
      'message': message,
      'sunrise': sunrise,
      'sunset': sunset,
      'type': type
    };
  }

  // Override the == operator
  @override
  bool operator ==(o) =>
      o is Sys &&
      country == o.country &&
      id == o.id &&
      message == o.message &&
      sunrise == o.sunrise &&
      sunset == o.sunset &&
      type == o.type;

  // Override the get hashcode method
  @override
  int get hashCode =>
      country.hashCode ^
      id.hashCode ^
      message.hashCode ^
      sunrise.hashCode ^
      sunset.hashCode ^
      type.hashCode;
}
