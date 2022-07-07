import 'package:flutter/material.dart';
import 'package:cuaca/theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailWeather extends StatelessWidget {
  String identifier;
  int number;
  String satuan;
  double takeData;

  DetailWeather(
      {required this.identifier,
      required this.number,
      required this.satuan,
      required this.takeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          identifier,
          style: statsTextStyle,
        ),
        Text(
          '$number',
          style: statsTextStyle,
        ),
        Text(
          satuan,
          style: statsTextStyle,
        ),
        SizedBox(
          height: 5,
        ),
        LinearPercentIndicator(
          width: 80,
          animation: true,
          lineHeight: 2.5,
          animationDuration: 2000,
          percent: takeData,
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: Colors.green,
        ),
      ],
    );
  }
}
