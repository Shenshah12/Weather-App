import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:finallab/Services/weather.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  late double latitude;
  late double longitude;

  //used when before running build method, we can say that it is used for preprocessing of an app build
  @override
  void initState() {

    super.initState();
    getLocationData();
  }

  //used when the object is destroyed
  // @override
  // void deactivate() {
  //   // TODO: implement deactivate
  //   super.deactivate();
  // }
  void getLocationData() async {

    var weather_model=await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute<void>(builder: (context){
      return LocationScreen(weather_model);
    }));

  }


  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.lightGreen,
          size: 100,
        ),
      ),
    );
    // return Scaffold(
    //   body: Center(
    //     child: ElevatedButton(
    //       onPressed: () {
    //         //Get the current location
    //       },
    //       child: Text('Get Location'),
    //     ),
    //   ),
    // );
  }
}
