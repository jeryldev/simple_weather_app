import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather_app/core/network/network_info.dart';
import 'package:simple_weather_app/features/current_weather/data/data_sources/current_weather_local_data_source.dart';
import 'package:simple_weather_app/features/current_weather/data/data_sources/current_weather_remote_data_source.dart';
import 'package:simple_weather_app/features/current_weather/data/repositories/current_weather_repository_implementation.dart';
import 'package:simple_weather_app/features/current_weather/domain/repositories/current_weather_repository.dart';
import 'package:simple_weather_app/features/current_weather/domain/usecases/get_current_weather_city.dart';
import 'package:simple_weather_app/features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc
  serviceLocator
      .registerFactory(() => CurrentWeatherBloc(cityString: serviceLocator()));

  // Use cases
  serviceLocator
      .registerLazySingleton(() => GetCurrentWeatherCity(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<CurrentWeatherRepository>(() =>
      CurrentWeatherRepositoryImplementation(
          remoteDataSource: serviceLocator(),
          localDataSource: serviceLocator(),
          networkInfo: serviceLocator()));

  // Data sources
  serviceLocator.registerLazySingleton<CurrentWeatherLocalDataSource>(() =>
      CurrentWeatherLocalDataSourceImplementation(
          sharedPreferences: serviceLocator()));

  serviceLocator.registerLazySingleton<CurrentWeatherRemoteDataSource>(() =>
      CurrentWeatherRemoteDataSourceImplementation(client: serviceLocator()));

  //! Core
  serviceLocator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplementation(serviceLocator()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => DataConnectionChecker());
}
