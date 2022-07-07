import 'package:cuaca/services/images_list.dart';
import 'package:cuaca/services/weather.dart';
import 'package:cuaca/theme.dart';
import 'package:flutter/material.dart';

const defaultMargin = 20.0;

class WideWebPage extends StatefulWidget {
  final locationWeather;

  WideWebPage({
    this.locationWeather,
  });
  @override
  State<WideWebPage> createState() => _WideWebPageState();
}

class _WideWebPageState extends State<WideWebPage> {
  ImageList imageList = ImageList();
  Weather weather = Weather();

  String? typedCityName;
  String? cityName;
  String? weatherDesc;
  int? temp;
  late int humidity;
  late int windSpeed;
  late int cloudsPercentage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(
      widget.locationWeather,
    );
  }

  double getStats(int data) {
    double stats = data / 100;
    return stats;
  }

  void updateUI(
    dynamic weatherData,
  ) {
    setState(() {
      if (weatherData == null) {
        cityName = '';
        weatherDesc = '';
        humidity = 0;
        windSpeed = 0;
        cloudsPercentage = 0;
        temp = 0;

        return;
      }
      cityName = weatherData['name'];
      weatherDesc = weatherData['weather'][0]['main'];
      humidity = weatherData['main']['humidity'];
      double windSpd = weatherData['wind']['speed'];
      windSpeed = windSpd.toInt();
      cloudsPercentage = weatherData['clouds']['all'];
      double temperature = weatherData['main']['temp'];
      temp = temperature.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/widewebblur.jpg'),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 400,
              height: MediaQuery.of(context).size.height - 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/wideweb.jpg',
                    ),
                    fit: BoxFit.cover),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: defaultMargin, vertical: defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () async {
                            var weatherData =
                                await weather.getLocationWeather();

                            updateUI(
                              weatherData,
                            );
                          },
                          icon: Icon(Icons.refresh,
                              size: 30, color: Colors.white),
                        ),
                        SizedBox(
                          height: 40,
                          width: 175,
                          child: TextFormField(
                            onChanged: (value) {
                              typedCityName = value;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  if (typedCityName != null) {
                                    var weatherData =
                                        await weather.getCityWeather(
                                      typedCityName.toString(),
                                    );
                                    updateUI(weatherData);
                                  }
                                },
                                icon: Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.cloud_outlined,
                                color: Colors.white,
                                size: 200,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                '$temp°',
                                style: temperatureTextStyle.copyWith(
                                    fontSize: 120),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '$cityName',
                                overflow: TextOverflow.ellipsis,
                                style: cityNameTextStyle,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Humidity ${humidity.toInt()}%',
                                style: statsTextStyle,
                              ),
                              Text(
                                'Cloud Percentage $cloudsPercentage%',
                                style: statsTextStyle,
                              ),
                              Text(
                                'Wind Speed $windSpeed km/h',
                                style: statsTextStyle,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
