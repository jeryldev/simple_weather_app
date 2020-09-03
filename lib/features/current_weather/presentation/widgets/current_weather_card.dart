import 'package:flutter/material.dart';

import 'package:simple_weather_app/features/current_weather/domain/entities/current_weather.dart';
import 'package:transparent_image/transparent_image.dart';

import './widgets.dart';

class CurrentWeatherCard extends StatefulWidget {
  final CurrentWeather currentWeather;
  const CurrentWeatherCard({
    Key key,
    @required this.currentWeather,
  }) : super(key: key);

  @override
  _CurrentWeatherCardState createState() => _CurrentWeatherCardState();
}

class _CurrentWeatherCardState extends State<CurrentWeatherCard> {
  @override
  Widget build(BuildContext context) {
    String location =
        widget.currentWeather.name + ", " + widget.currentWeather.sys.country;
    String tempInCelsius = (widget.currentWeather.main.temp - 273.15)
            .toStringAsFixed(1)
            .titleCase +
        "\u00B0";
    String weatherDescription =
        (widget.currentWeather.weather[0].description).titleCase;

    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.tealAccent[400],
              Colors.cyan[300],
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            // stops: [0.15, 1.00],
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
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
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image:
                          "http://openweathermap.org/img/wn/${widget.currentWeather.weather[0].icon}@2x.png",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
