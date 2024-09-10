import 'package:finallab/Services/location.dart';
import 'package:finallab/Services/networking.dart';

const String apiKey = '717d2bf5be532804a89471bf115e5be2'; // Your actual API key
const String openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityname) async
  {
    var url="$openWeatherMapURL?q=$cityname&appid=$apiKey&units=metric";
    networkHelper helps_network=networkHelper(url);
    var city_weather_data=await helps_network.getData();
    return city_weather_data;
  }

  Future<dynamic> getLocationWeather()async{
    Location location=Location();
    await location.getCurrentLocation();
    location.latitude;
    location.longitude;

    String url_with_key='$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';

    networkHelper network=networkHelper(url_with_key);

    var weatherData=await network.getData();
    return weatherData;


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
    if (temp > 30) {
      return "Welcome to the 🔥 inferno. It's melting time!";
    } else if (temp > 20&&temp<=30) {
      return "Time to show off those legs in 🩳 and 👕. Don't forget sunscreen!";
    } else if (temp <=20 && temp>10 ) {
      return "Brrr! It's freezing out there. Don't leave home without 🧣 and 🧤";
    } else {
      return 'Better safe than sorry. Bring a 🧥 just in case the weather decides to play tricks.';
    }
  }
}
