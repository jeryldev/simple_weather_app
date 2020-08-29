import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_weather_app/core/error/exception.dart';
import 'package:simple_weather_app/core/error/failure.dart';
import 'package:simple_weather_app/core/network/network_info.dart';
import 'package:simple_weather_app/features/current_weather/data/data_sources/current_weather_local_data_source.dart';
import 'package:simple_weather_app/features/current_weather/data/data_sources/current_weather_remote_data_source.dart';
import 'package:simple_weather_app/features/current_weather/data/models/current_weather_model.dart';
import 'package:simple_weather_app/features/current_weather/data/repositories/current_weather_repository_implementation.dart';
import 'package:simple_weather_app/features/current_weather/domain/entities/current_weather.dart';

class MockRemoteDataSource extends Mock
    implements CurrentWeatherRemoteDataSource {}

class MockLocalDataSource extends Mock
    implements CurrentWeatherLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  CurrentWeatherRepositoryImplementation repositoryImplementation;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImplementation = CurrentWeatherRepositoryImplementation(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getCityCurrentWeather', () {
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

    final testCityName = 'London';

    final CurrentWeather testCityCurrentWeather = testCurrentWeatherModel;

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repositoryImplementation.getCityCurrentWeather(testCityName);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getCityCurrentWeather(any))
            .thenAnswer((_) async => testCurrentWeatherModel);
        // act
        final result =
            await repositoryImplementation.getCityCurrentWeather(testCityName);
        // assert
        verify(mockRemoteDataSource.getCityCurrentWeather(testCityName));
        expect(result, equals(Right(testCityCurrentWeather)));
      });
      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getCityCurrentWeather(any))
            .thenAnswer((_) async => testCurrentWeatherModel);
        // act
        await repositoryImplementation.getCityCurrentWeather(testCityName);
        // assert
        verify(mockRemoteDataSource.getCityCurrentWeather(testCityName));
        verify(mockLocalDataSource
            .cacheCityCurrentWeather(testCurrentWeatherModel));
      });
      test(
          'should return ServerFailure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getCityCurrentWeather(any))
            .thenThrow(ServerException());
        // act
        final result =
            await repositoryImplementation.getCityCurrentWeather(testCityName);
        // assert
        verify(mockRemoteDataSource.getCityCurrentWeather(testCityName));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastCityCurrentWeather())
            .thenAnswer((_) async => testCurrentWeatherModel);
        // act
        final result =
            await repositoryImplementation.getCityCurrentWeather(testCityName);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastCityCurrentWeather());
        expect(result, equals(Right(testCityCurrentWeather)));
      });
      test('should return CacheFailure when there is no cached data', () async {
        // arrange
        when(mockLocalDataSource.getLastCityCurrentWeather())
            .thenThrow(CacheException());
        // act
        final result =
            await repositoryImplementation.getCityCurrentWeather(testCityName);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastCityCurrentWeather());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
