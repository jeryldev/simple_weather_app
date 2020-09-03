import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:simple_weather_app/features/current_weather/domain/entities/current_weather.dart';
import './widgets.dart';

class CurrentWeatherCard extends StatelessWidget {
  final CurrentWeather currentWeather;

  const CurrentWeatherCard({Key key, this.currentWeather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String location = currentWeather.name + ", " + currentWeather.sys.country;
    String tempInCelsius =
        (currentWeather.main.temp - 273.15).toStringAsFixed(1).titleCase +
            "\u00B0";
    String weatherDescription =
        (currentWeather.weather[0].description).titleCase;
    String weatherIcon = currentWeather.weather[0].icon;

    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // Colors.tealAccent[400],
              // Colors.cyan[300],
              Colors.orange,
              Colors.orange[900]
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            // stops: [0.15, 1.00],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildLocationWeatherSummary(
                location, tempInCelsius, weatherDescription),
            buildWeatherIconWidget(weatherIcon),
          ],
        ),
      ),
    );
  }

  Expanded buildLocationWeatherSummary(
      String location, String tempInCelsius, String weatherDescription) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            location,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          Text(
            tempInCelsius,
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          Text(
            weatherDescription,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildWeatherIconWidget(String weatherIcon) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl: "http://openweathermap.org/img/wn/$weatherIcon@2x.png",
              placeholder: (context, url) => CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ],
      ),
    );
  }
}
