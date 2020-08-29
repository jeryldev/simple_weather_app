import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:simple_weather_app/core/error/exception.dart';
import 'package:simple_weather_app/features/current_weather/data/data_sources/current_weather_remote_data_source.dart';
import 'package:simple_weather_app/features/current_weather/data/models/current_weather_model.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() async {
  CurrentWeatherRemoteDataSourceImplementation
      currentWeatherRemoteDataSourceImplementation;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    currentWeatherRemoteDataSourceImplementation =
        CurrentWeatherRemoteDataSourceImplementation(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('current_weather.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getCityCurrentWeather', () {
    final testCity = 'London';
    final testCityCurrentWeatherModel = CurrentWeatherModel.fromJson(
        json.decode(fixture('current_weather.json')));

    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      currentWeatherRemoteDataSourceImplementation
          .getCityCurrentWeather(testCity);
      // assert
      verify(mockHttpClient.get(
        'http://api.openweathermap.org/data/2.5/weather?q=$testCity&appid=cd4b80ffa7a59f7415f0b8a62e2e141e',
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test('should return CurrentWeather when the status code is 200 success',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await currentWeatherRemoteDataSourceImplementation
          .getCityCurrentWeather(testCity);
      // assert
      expect(result, equals(testCityCurrentWeatherModel));
    });

    test('should throw a ServerException when the status code is not 200',
        () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call =
          currentWeatherRemoteDataSourceImplementation.getCityCurrentWeather;
      // assert
      expect(() => call(testCity), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
