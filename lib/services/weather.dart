import 'package:cilmate_check/services/location.dart';
import 'package:cilmate_check/services/networking.dart';
import 'package:cilmate_check/utilities/constants.dart';

class WeatherModel {
  // For particular city search.
  Future<dynamic> getCityWeather(String cityName) async {
    var url = Uri.https('api.openweathermap.org', 'data/2.5/weather',
        {'q': '$cityName', 'appid': '$kApiKey', 'units': 'metric'});
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var jsonResponseForCity = await networkHelper.getData();
    return jsonResponseForCity;
  }
 // For particular location search
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    var url = Uri.https('api.openweathermap.org', 'data/2.5/weather', {
      'lat': '${location.latitude}',
      'lon': '${location.longitude}',
      'appid': '$kApiKey',
      'units': 'metric'
    });
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var jsonResponse = await networkHelper.getData();
    return jsonResponse;
  }

  String getWeatherIcon(int condition) {
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

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
