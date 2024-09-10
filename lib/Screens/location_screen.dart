import 'package:flutter/material.dart';
import 'package:finallab/Utilities/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:finallab/Services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationweather;

  LocationScreen(this.locationweather);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    newUI(widget.locationweather);
  }

  WeatherModel current_weather = WeatherModel();
  int temperature = 0;
  String weather_icon = '';
  String city_name = '';
  String weather_msg = '';

  void newUI(dynamic weatherdata) {
    setState(() {
      // check if the location is deactivated for user{ for my app i have added an obligation that app must have location turned on else it will load infinite times}
      if (weatherdata == null) {
        int temperature = 0;
        String weather_icon = 'Error';
        String city_name = '';
        String weather_msg =
            'Unable to get location, please turn on your location services on mobile';
        return;
      }

      double temp = weatherdata['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherdata['weather'][0]['id'];
      weather_icon = current_weather.getWeatherIcon(condition);
      weather_msg = current_weather.getMessage(temperature);
      city_name = weatherdata['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/app_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weather_data =
                          await current_weather.getLocationWeather();
                      newUI(weather_data);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.black45,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var TypeName=await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if(TypeName!=null)
                        {
                          var get_city_weather_data=await current_weather.getCityWeather(TypeName);
                          newUI(get_city_weather_data);

                        }
                      print(TypeName);

                    },
                    child: const Icon(
                      color: Colors.black45,
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
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weather_icon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weather_msg in $city_name!",
                  textAlign: TextAlign.right,
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
