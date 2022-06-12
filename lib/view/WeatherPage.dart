import 'package:flutter/material.dart';
import 'package:istegelsinfinal/utils/WeatherData.dart';

class WeatherPage extends StatefulWidget {
  final WeatherData weatherData;
  WeatherPage({required this.weatherData});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late int temp;
  late Icon weatherDisplayIcon;
  late AssetImage background;
  late String city;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temp = weatherData.currentTemp.round();
      city = weatherData.city;
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      background = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  initState() {
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(image: background, fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(child: weatherDisplayIcon),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "${temp}°",
                style: TextStyle(
                    color: Colors.white, fontSize: 80.0, letterSpacing: -5),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                city,
                style: TextStyle(
                    color: Colors.white, fontSize: 80.0, letterSpacing: -5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
