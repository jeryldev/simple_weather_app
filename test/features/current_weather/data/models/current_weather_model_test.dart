import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_weather_app/features/current_weather/data/models/current_weather_model.dart';
import 'package:simple_weather_app/features/current_weather/domain/entities/current_weather.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  Main testMain = new Main(
      temp: 280.32,
      pressure: 1012,
      humidity: 81,
      temp_min: 279.15,
      temp_max: 281.15);

  Weather testWeather = new Weather(
      id: 300,
      main: "Drizzle",
      description: "light intensity drizzle",
      icon: "09d");
  List<Weather> testWeatherList = [testWeather];

  Sys testSys = new Sys(
      type: 1,
      id: 5091,
      message: 0.0103,
      country: "GB",
      sunrise: 1485762037,
      sunset: 1485794875);

  final testCurrentWeatherModel = CurrentWeatherModel(
      name: 'London', main: testMain, weather: testWeatherList, sys: testSys);

  test('should be based on the CurrentWeatherModel', () async {
    // arrange

    // act

    // assert
    expect(testCurrentWeatherModel, isA<CurrentWeather>());
  });

  group('fromJson', () {
    test('should return a Current Weather Model', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('current_weather.json'));
      // act
      final result = CurrentWeatherModel.fromJson(jsonMap);
      expect(result.name, testCurrentWeatherModel.name);
      expect(result.sys, equals(testCurrentWeatherModel.sys));
      expect(result.main, equals(testCurrentWeatherModel.main));
      expect(result.weather, equals(testCurrentWeatherModel.weather));
      expect(result, testCurrentWeatherModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      final result = testCurrentWeatherModel.toJson();
      // act
      final expectedMap = {
        "name": "London",
        "main": {
          "temp": 280.32,
          "pressure": 1012,
          "humidity": 81,
          "temp_min": 279.15,
          "temp_max": 281.15
        },
        "sys": {
          "type": 1,
          "id": 5091,
          "message": 0.0103,
          "country": "GB",
          "sunrise": 1485762037,
          "sunset": 1485794875
        },
        "weather": [
          {
            "id": 300,
            "main": "Drizzle",
            "description": "light intensity drizzle",
            "icon": "09d"
          }
        ]
      };

      // assert
      expect(result, expectedMap);
    });
  });
}
