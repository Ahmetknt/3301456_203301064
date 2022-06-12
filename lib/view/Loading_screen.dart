import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:istegelsinfinal/utils/WeatherData.dart';

import 'Location.dart';
import 'WeatherPage.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;

  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if (locationData.lati == null || locationData.long == null) {
      debugPrint("Konum bilgileri gelmiyor");
    } else {
      debugPrint("Lati : ${locationData.lati}");
      debugPrint("Long : ${locationData.long}");
    }
  }

  void getWeatherData() async {
    await getLocationData();
    WeatherData weatherData = WeatherData(locationdata: locationData);
    await weatherData.getTemp();

    if (weatherData.currentTemp == null ||
        weatherData.currentCondition == null) {
      debugPrint("API den sıcaklık veya durum bilgisi boş dönüyor");
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WeatherPage(
                  weatherData: weatherData,
                )));
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple, Colors.blue])),
        child: Center(
          child: SpinKitCubeGrid(
            color: Colors.black,
            size: 150.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
