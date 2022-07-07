import 'package:cuaca/services/weather.dart';
import 'package:cuaca/theme.dart';
import 'package:flutter/material.dart';
import 'package:cuaca/widgets/detail_widget.dart';

const defaultMargin = 20.0;

class TabPage extends StatefulWidget {
  final locationWeather;

  TabPage({
    this.locationWeather,
  });
  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
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
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/2.jpg'), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              width: 400,
              height: MediaQuery.of(context).size.height - 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white,
                  )),
              child: Stack(
                children: [
                  Column(
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
                          margin:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: defaultMargin),
                        child: IconButton(
                          onPressed: () async {
                            var weatherData =
                                await weather.getLocationWeather();

                            updateUI(
                              weatherData,
                            );
                          },
                          icon: Icon(
                            Icons.refresh_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: defaultMargin),
                        child: SizedBox(
                          height: 40,
                          width: 160,
                          child: TextFormField(
                            onChanged: (value) {
                              typedCityName = value;
                            },
                            style: TextStyle(color: Colors.white),
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
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
