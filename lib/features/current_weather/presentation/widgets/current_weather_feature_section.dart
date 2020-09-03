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
background      return MessageDisplayWidget(
        messageText: 'Start searching!',
        gradientColorList: [
          Colors.tealAccent[400],
          Colors.cyan[300],
          // Colors.orange,
          // Colors.orange[900]
        ],
      );
    } else if (state is Loading) {
      return LoadingWidget();
    } else if (state is Loaded) {
      return CurrentWeatherCard(currentWeather: state.currentWeather);
    } else if (state is Error) {
      return MessageDisplayWidget(
        messageText: state.errorMessage == 'Server failure'
            ? 'Location not found.'
            : 'Error has occurred.',
        gradientColorList: [
          Colors.pinkAccent[400],
          Colors.red,
          // Colors.orange,
          // Colors.orange[900]
        ],
      );
    }
  }
}
