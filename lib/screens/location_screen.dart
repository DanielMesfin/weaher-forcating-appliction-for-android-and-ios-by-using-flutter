import 'package:flutter/material.dart';
import 'package:cilmate_check/utilities/constants.dart';
import 'package:cilmate_check/services/weather.dart';
import 'package:cilmate_check/screens/city_screen.dart';
class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
   int temprture=0;
   String conditionIcon='';
   String conditionMessage='';
   String cityName='';
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }
  void updateUI(dynamic weatherData){
    setState(() {
      if(weatherData==null){
        temprture=0;
        conditionMessage='Unable To get the city ';
        cityName='';
        return;
      }
      double temp=weatherData['main']['temp'];
      temprture=temp.toInt();
      conditionMessage=weather.getMessage(temprture);
      var condition=weatherData['weather'][0]['id'];
      conditionIcon=weather.getWeatherIcon(condition);
      cityName=weatherData['name'];
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{
                      var currentWeather= await weather.getLocationWeather();
                      updateUI(currentWeather);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typedName=await  Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();

                      },),);
                      if(typedName!=null){
                        var resultDataFromNetwork=await weather.getCityWeather(typedName);
                        updateUI(resultDataFromNetwork);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprture°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$conditionIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "$conditionMessage in $cityName!",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
