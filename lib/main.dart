import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/network_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/get_weather_condition_screen.dart';
import 'package:weather_app/screens/network_error_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NetworkInfoImpl()),
          ChangeNotifierProvider(create: (context) => WeatherProvider()),
        ],
        child: MaterialApp(
            title: 'Weather',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen()));
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleNetwork();
  }

  _handleNetwork() {
    Future.delayed(Duration.zero, () {
      Provider.of<NetworkInfoImpl>(context, listen: false)
          .checkNewtworkStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkInfoImpl>(builder: (context, value, child) {
      return AnimatedSplashScreen(
          duration: 3000,
          splash: const Text(
            'WEATHER',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          nextScreen: value.networkStatus == true
              ? const HomeScreen()
              : const NetworkErrorScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.blue.shade400);
    });
  }
}
