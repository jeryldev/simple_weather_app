import 'dart:convert';

import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather_app/core/error/exception.dart';
import 'package:simple_weather_app/features/current_weather/data/data_sources/current_weather_local_data_source.dart';
import 'package:simple_weather_app/features/current_weather/data/models/current_weather_model.dart';
import 'package:simple_weather_app/features/current_weather/domain/entities/current_weather.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  CurrentWeatherLocalDataSourceImplementation
      currentWeatherLocalDataSourceImplementation;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    currentWeatherLocalDataSourceImplementation =
        CurrentWeatherLocalDataSourceImplementation(
            sharedPreferences: mockSharedPreferences);
  });

  group('cacheCityCurrentWeather', () {
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

    test('should call sharedpreferences to cache the data', () async {
      // arrange

      // act
      currentWeatherLocalDataSourceImplementation
          .cacheCityCurrentWeather(testCurrentWeatherModel);
      // assert
      final expectedJsonString = json.encode(testCurrentWeatherModel.toJson());
      verify(mockSharedPreferences.setString(
          CACHED_CITY_CURRENT_WEATHER, expectedJsonString));
    });
  });

  group('getLastCityCurrentWeather', () {
    final testCurrentWeatherModel = CurrentWeatherModel.fromJson(
        json.decode(fixture('current_weather_cached.json')));
    test(
        'should return NumberTriviaModel from SharedPreferences when there is a cached value',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('current_weather_cached.json'));
      // act
      final result = await currentWeatherLocalDataSourceImplementation
          .getLastCityCurrentWeather();
      // assert
      verify(mockSharedPreferences.getString(CACHED_CITY_CURRENT_WEATHER));
      expect(result, equals(testCurrentWeatherModel));
    });
    test(
        'should return CacheException from SharedPreferences when there is no cache value',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call =
          currentWeatherLocalDataSourceImplementation.getLastCityCurrentWeather;
      // assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });
}
