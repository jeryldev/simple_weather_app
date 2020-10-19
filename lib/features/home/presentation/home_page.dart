import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather_app/features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'package:simple_weather_app/features/current_weather/presentation/widgets/widgets.dart';
import 'package:simple_weather_app/injection_container.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildHomePageAppBar(),
      body: SingleChildScrollView(child: buildHomePageBody(context)),
    );
  }

  BlocProvider<CurrentWeatherBloc> buildHomePageBody(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<CurrentWeatherBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CurrentWeatherControls(),
              SizedBox(height: 10.0),
              BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
                builder: (context, state) {
                  return CurrentWeatherFeatureSection(state: state);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildHomePageAppBar() {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.account_circle),
        iconSize: 30.0,
        onPressed: () {},
      ),
      title: Text(
        'Simple Weather',
      ),
      actions: [
        FlatButton(
          onPressed: () {},
          child: Text(
            'List',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ],
    );
  }
}
