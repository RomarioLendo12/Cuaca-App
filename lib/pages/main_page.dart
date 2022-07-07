import 'package:cuaca/pages/mobile_page.dart';
import 'package:cuaca/pages/tab_page.dart';
import 'package:cuaca/pages/wide_web_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final locationWeather;

  MainPage({
    required this.locationWeather,
  });
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return MobilePage(
              locationWeather: widget.locationWeather,
            );
          } else if (constraints.maxWidth <= 1000) {
            return TabPage(
              locationWeather: widget.locationWeather,
            );
          } else {
            return WideWebPage(
              locationWeather: widget.locationWeather,
            );
          }
        },
      ),
    );
  }
}
