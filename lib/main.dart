import 'package:flutter/material.dart';
import 'package:simple_weather_app/features/home/presentation/home_page.dart';

import 'injection_container.dart' as dependencyInjection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencyInjection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Simple Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // primaryColor: Colors.deepOrange[400],
          primaryColor: Colors.redAccent,
          scaffoldBackgroundColor: Colors.grey[50] // accentColor: Colors.blue,
          ),
      // home: CurrentWeatherPage(),
      home: HomePage(),
    );
  }
}
