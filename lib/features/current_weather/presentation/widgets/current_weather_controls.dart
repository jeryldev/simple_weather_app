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
        TextField(
          onChanged: (value) => inputString = value,
          controller: inputTextController,
          keyboardType: TextInputType.text,
          onSubmitted: (_) => dispatchCityCurrentWeather(),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Search for a city, country'),
        ),
        SizedBox(height: 10),
        RaisedButton(
          onPressed: dispatchCityCurrentWeather,
          child: Text('Search'),
          color: Theme.of(context).accentColor,
          textTheme: ButtonTextTheme.primary,
        ),
      ],
    );
  }

  void dispatchCityCurrentWeather() {
    inputTextController.clear();
    BlocProvider.of<CurrentWeatherBloc>(context)
        .add(GetCurrentWeatherForCityEvent(inputString));
    FocusManager.instance.primaryFocus.unfocus();
  }
}
