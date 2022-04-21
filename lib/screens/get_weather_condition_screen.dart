import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/style/constants.dart';

class WeatherConditionScreen extends StatefulWidget {
  WeatherConditionScreen({
    required this.locationName,
    Key? key,
  }) : super(key: key);

  String locationName;
  @override
  State<WeatherConditionScreen> createState() => _WeatherConditionScreenState();
}

class _WeatherConditionScreenState extends State<WeatherConditionScreen> {
  @override
  void initState() {
    super.initState();
    _handleWeatherConditon();
  }

  _handleWeatherConditon() {
    Future.delayed(Duration.zero, () async {
      await Provider.of<WeatherProvider>(context, listen: false)
          .fetchLocation(widget.locationName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          return weatherProvider.weatherStatus == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                'assets/images/weather_screen.jpeg')),
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 10),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            weatherProvider.weatherStatus.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                          ),
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
