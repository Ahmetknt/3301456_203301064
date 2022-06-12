import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:istegelsinfinal/view/Location.dart';

const apiKey = "56cee65311997e7bb10288e5aa2b69d7";

class WeatherDisplayData {
  late Icon weatherIcon;
  late AssetImage weatherImage;
  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  WeatherData({required this.locationdata});
  LocationHelper locationdata;

  double currentTemp = 0.0;
  int currentCondition = 0;
  String city = "";

  Future<void> getTemp() async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${locationdata.lati}&lon=${locationdata.long}&appid=${apiKey}&units=metric");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      var currentWeather = jsonDecode(data);

      try {
        currentTemp = currentWeather['main']['temp'];
        city = currentWeather['name'];
        currentCondition = currentWeather['weather'][0]['id'];

        debugPrint("${city}");
        debugPrint("${currentTemp}");
        debugPrint("${currentCondition}");
      } catch (e) {
        debugPrint("awq");
      }
    } else {
      debugPrint("Apiden veri gelmiyor");
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 600) {
      return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.cloud,
            size: 100.0,
            color: Colors.white,
          ),
          weatherImage: AssetImage("images/bulutlu.png"));
    } else {
      var now = new DateTime.now();
      if (now.hour >= 19) {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.moon,
              size: 100.0,
              color: Colors.white,
            ),
            weatherImage: AssetImage("images/gece.png"));
      } else {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 100.0,
              color: Colors.white,
            ),
            weatherImage: AssetImage("images/gunesli.png"));
      }
    }
  }
}
