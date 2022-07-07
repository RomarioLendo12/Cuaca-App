import 'package:cuaca/pages/search_page.dart';
import 'package:cuaca/services/images_list.dart';
import 'package:cuaca/services/weather.dart';
import 'package:cuaca/theme.dart';
import 'package:flutter/material.dart';
import 'package:cuaca/widgets/detail_widget.dart';

const defaultMargin = 20.0;

class MobilePage extends StatefulWidget {
  final locationWeather;

  MobilePage({
    this.locationWeather,
  });
  @override
  State<MobilePage> createState() => _MobilePageState();
}

class _MobilePageState extends State<MobilePage> {
  Weather weather = Weather();

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

  void updateUI(dynamic weatherData) {
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
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
          padding: EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () async {
              var weatherData = await weather.getLocationWeather();

              updateUI(weatherData);
            },
            child: Icon(
              Icons.refresh,
              size: 30,
            ),
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
                var typedCity = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => SearchPage(),
                  ),
                );
                if (typedCity != null) {
                  var weatherData = await weather.getCityWeather(typedCity);
                  updateUI(weatherData);
                }
              },
              icon: Icon(
                Icons.search_outlined,
                size: 30,
              ),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/2.jpg'), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$cityName',
                        overflow: TextOverflow.ellipsis,
                        style: cityNameTextStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$temp°',
                        style: temperatureTextStyle,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.cloud_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            '$weatherDesc',
                            style: weatherDescTextStyle,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Divider(
                  color: Colors.white.withOpacity(0.5),
                  thickness: 1,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(
                      left: defaultMargin,
                      right: defaultMargin,
                      bottom: defaultMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DetailWeather(
                          takeData: getStats(windSpeed),
                          identifier: 'Wind',
                          number: windSpeed,
                          satuan: 'km/h'),
                      DetailWeather(
                        takeData: getStats(cloudsPercentage),
                        identifier: 'Rain',
                        number: cloudsPercentage,
                        satuan: '%',
                      ),
                      DetailWeather(
                          takeData: getStats(humidity),
                          identifier: 'Humidity',
                          number: humidity.toInt(),
                          satuan: '%'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
