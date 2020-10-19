import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather_app/features/current_weather/presentation/bloc/current_weather_bloc.dart';

class CurrentWeatherControls extends StatefulWidget {
  CurrentWeatherControls({Key key}) : super(key: key);

  @override
  _CurrentWeatherControlsState createState() => _CurrentWeatherControlsState();
}

class _CurrentWeatherControlsState extends State<CurrentWeatherControls> {
  final inputTextController = TextEditingController();
  String inputString;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            onChanged: (value) => inputString = value,
            controller: inputTextController,
            keyboardType: TextInputType.text,
            onSubmitted: (_) => dispatchCityCurrentWeather(),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(
                  Icons.search,
                  size: 30.0,
                ),
                suffixIcon: IconButton(
                  onPressed: clearCityCurrentWeather,
                  icon: Icon(
                    Icons.clear,
                    size: 30,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(width: 0.8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      width: 0.8, color: Theme.of(context).primaryColor),
                ),
                hintText: 'Search for a city, country'),
          ),
        ),
        // SizedBox(height: 10),
        // RaisedButton(
        //   onPressed: dispatchCityCurrentWeather,
        //   child: Text('Search'),
        //   color: Theme.of(context).accentColor,
        //   textTheme: ButtonTextTheme.primary,
        // ),
      ],
    );
  }

  void dispatchCityCurrentWeather() {
    inputTextController.clear();
    BlocProvider.of<CurrentWeatherBloc>(context)
        .add(GetCurrentWeatherForCityEvent(inputString));
    FocusManager.instance.primaryFocus.unfocus();
  }

  void clearCityCurrentWeather() {
    inputTextController.clear();
    FocusManager.instance.primaryFocus.unfocus();
  }
}
