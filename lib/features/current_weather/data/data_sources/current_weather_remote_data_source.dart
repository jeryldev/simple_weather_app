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

  CurrentWeatherRemoteDataSourceImplementation({@required this.client});

  @override
  Future<CurrentWeatherModel> getCityCurrentWeather(String city) {
    // TODO: implement getCityCurrentWeather
    throw UnimplementedError();
  }

  Future<CurrentWeatherModel> _getCurrentWeatherFromUrl(String url) async {
    final response = await client.get(url, headers: {
      'Content-Type': 'application/json',
    });
  }
}
