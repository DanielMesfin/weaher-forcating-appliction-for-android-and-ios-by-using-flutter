import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:cilmate_check/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '30556f6021356b0df6b6244e5822b418';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

//TODO These method is used for getting the  user location from it device
  void getLocation() async {
    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(
            locationWeather: weatherData,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.teal,
          size: 100.0,
        ),
      ),
    );
  }
}
