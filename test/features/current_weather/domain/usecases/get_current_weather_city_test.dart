import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_weather_app/features/current_weather/domain/entities/current_weather.dart';
import 'package:simple_weather_app/features/current_weather/domain/repositories/current_weather_repository.dart';
import 'package:simple_weather_app/features/current_weather/domain/usecases/get_current_weather_city.dart';

class MockCurrentWeatherRepository extends Mock
    implements CurrentWeatherRepository {}

void main() {
  GetCurrentWeatherCity useCase;
  MockCurrentWeatherRepository mockCurrentWeatherRepository;

  setUp(() {
    mockCurrentWeatherRepository = new MockCurrentWeatherRepository();
    useCase = GetCurrentWeatherCity(mockCurrentWeatherRepository);
  });

  final testCityName = "Taguig";

  final testCurrentWeather = CurrentWeather(name: "Taguig");

  test('should get the current weather of the city from the repository',
      () async {
    // arrange
    when(mockCurrentWeatherRepository.getCityCurrentWeather(any))
        .thenAnswer((_) async => Right(testCurrentWeather));
    // act
    final result = await useCase(Params(city: testCityName));
    // assert
    expect(result, Right(testCurrentWeather));
    verify(mockCurrentWeatherRepository.getCityCurrentWeather(testCityName));
    verifyNoMoreInteractions(mockCurrentWeatherRepository);
  });
}
