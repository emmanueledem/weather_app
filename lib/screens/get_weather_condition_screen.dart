import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/style/constants.dart';

class WeatherConditionScreen extends StatefulWidget {
  const WeatherConditionScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WeatherConditionScreen> createState() => _WeatherConditionScreenState();
}

class _WeatherConditionScreenState extends State<WeatherConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          return SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/location_background.jpg')),
                color: Color(0xffFFFFFF),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              weatherProvider.temperature.toString() + '°C',
                              style: kTempTextStyle,
                            ),
                            Text(
                              weatherProvider
                                  .getWeatherIcon(weatherProvider.id),
                              style: kConditionTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        weatherProvider.weatherStatus.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0, top: 240),
                        child: Text(
                          weatherProvider
                                  .getMessage(weatherProvider.temperature) +
                              ' in ',
                          style: const TextStyle(
                              fontSize: 60, color: Colors.white),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 15.0,
                        ),
                        child: Text(
                          weatherProvider.location.toString(),
                          style: const TextStyle(
                              fontSize: 50, color: Colors.white),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
