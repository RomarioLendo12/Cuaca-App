import 'package:cuaca/pages/main_page.dart';

import 'package:cuaca/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await Weather().getLocationWeather();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => MainPage(
          locationWeather: weatherData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
