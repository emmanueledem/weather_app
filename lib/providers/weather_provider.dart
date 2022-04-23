import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class WeatherProvider extends ChangeNotifier {
  int? temperature;
  String? location;
  String? weatherStatus;
  int? id;
  String apiKey = 'fbca3848048e4cca75b36005457d9b3a';
  bool? ifCountryExist;
  bool saving = false;
  void manageProgress(value) {
    saving = value;
    notifyListeners();
  }

  Future fetchLocation(value) async {
    manageProgress(true);
    location = value;
    try {
      http.Response response = await http.get(Uri.parse(
          'http://api.openweathermap.org/geo/1.0/direct?q=$location&limit=1&appid=' +
              apiKey));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var lon = data[0]['lat'];
        var lat = data[0]['lon'];
        await fetchLocationData(lon, lat);
      }
    } catch (e) {
      ifCountryExist = false;
    }
    manageProgress(false);
    notifyListeners();
  }

  Future fetchLocationData(lon, lat) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=' +
            apiKey +
    '&units=metric'));
    
    var data = jsonDecode(response.body);

    id = data["weather"][0]['id'];
    double temp = data['main']['temp'];
    temperature = temp.toInt();
    weatherStatus = data["weather"][0]['description'];
    ifCountryExist = true;
    notifyListeners();
  }

  String getWeatherIcon(condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for short and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
