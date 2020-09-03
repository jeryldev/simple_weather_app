import 'package:flutter/material.dart';
import 'package:simple_weather_app/features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'package:simple_weather_app/features/current_weather/presentation/widgets/widgets.dart';

import 'loading_widget.dart';

class CurrentWeatherFeatureSection extends StatelessWidget {
  final CurrentWeatherState state;
  const CurrentWeatherFeatureSection({Key key, @required this.state})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: Center(
        child: displayFeature(state),
      ),
    );
  }

  // ignore: missing_return
  Widget displayFeature(CurrentWeatherState state) {
    if (state is Empty) {
      return Text('Start searching!');
    } else if (state is Loading) {
      return LoadingWidget();
    } else if (state is Loaded) {
      return CurrentWeatherCard(currentWeather: state.currentWeather);
    } else if (state is Error) {
      return Text(state.errorMessage.toString());
    }
  }
}
