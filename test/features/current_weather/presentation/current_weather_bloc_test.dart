import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_weather_app/core/error/failure.dart';
import 'package:simple_weather_app/features/current_weather/domain/entities/current_weather.dart';
import 'package:simple_weather_app/features/current_weather/domain/usecases/get_current_weather_city.dart';
import 'package:simple_weather_app/features/current_weather/presentation/bloc/current_weather_bloc.dart';

class MockGetCurrentWeatherCity extends Mock implements GetCurrentWeatherCity {}

void main() {
  CurrentWeatherBloc currentWeatherBloc;
  MockGetCurrentWeatherCity mockGetCurrentWeatherCity;

  setUp(() {
    mockGetCurrentWeatherCity = MockGetCurrentWeatherCity();
    currentWeatherBloc =
        CurrentWeatherBloc(cityString: mockGetCurrentWeatherCity);
  });

  test('initial state should be empty', () async {
    // arrange

    // act

    // assert
    expect(currentWeatherBloc.state, equals(Empty()));
  });

  group('GetCurrentWeatherCity', () {
    final testCity = "Taguig";
    final testCityCurrentWeather = CurrentWeather(name: "Taguig");

    test('should get current weather data for a city', () async {
      // arrange
      when(mockGetCurrentWeatherCity(any))
          .thenAnswer((_) async => Right(testCityCurrentWeather));
      // act
      currentWeatherBloc.add(GetCurrentWeatherForCityEvent(testCity));
      await untilCalled(mockGetCurrentWeatherCity(any));
      // assert
      verify(mockGetCurrentWeatherCity(Params(city: testCity)));
    });

    test('should emit [Loading, Loaded] when the data is gotten successfully',
        () async {
      // arrange
      when(mockGetCurrentWeatherCity(any))
          .thenAnswer((_) async => Right(testCityCurrentWeather));
      // act
      currentWeatherBloc.add(GetCurrentWeatherForCityEvent(testCity));
      // assert
      final expected = [
        Loading(),
        Loaded(currentWeather: testCityCurrentWeather)
      ];
      expect(currentWeatherBloc, emitsInOrder(expected));
    });

    test('should emit [Loading, Error] when getting data from Serverfails',
        () async {
      // arrange
      when(mockGetCurrentWeatherCity(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      currentWeatherBloc.add(GetCurrentWeatherForCityEvent(testCity));
      // numberTriviaBloc.close();
      // assert
      final expected = [
        // numberTriviaBloc.state,
        Loading(),
        Error(errorMessage: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(currentWeatherBloc, emitsInOrder(expected));
    });

    test(
        'should emit [Loading, Error] when getting data from Local Cache fails',
        () async {
      // arrange
      when(mockGetCurrentWeatherCity(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // act
      currentWeatherBloc.add(GetCurrentWeatherForCityEvent(testCity));
      // numberTriviaBloc.close();
      // assert
      final expected = [
        // numberTriviaBloc.state,
        Loading(),
        Error(errorMessage: CACHE_FAILURE_MESSAGE)
      ];
      expectLater(currentWeatherBloc, emitsInOrder(expected));
    });
  });
}
