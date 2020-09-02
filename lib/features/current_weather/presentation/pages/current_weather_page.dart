import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather_app/features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'package:simple_weather_app/injection_container.dart';
import '../widgets/widgets.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Current Weather App'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: buildbody(context),
        ),
      ),
    );
  }

  BlocProvider<CurrentWeatherBloc> buildbody(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<CurrentWeatherBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
                // ignore: missing_return
                builder: (context, state) {
                  return CurrentWeatherFeatureSection(state: state);
                },
              ),
              SizedBox(height: 20),
              CurrentWeatherControls()
            ],
          ),
        ),
      ),
    );
  }
}
