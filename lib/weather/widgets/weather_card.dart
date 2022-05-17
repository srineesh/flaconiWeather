import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../bloc/weather_bloc.dart';
import '../models/weather.dart';
import '../utils.dart';

class WeatherCard extends StatelessWidget {
  WeatherCard(
      {Key? key,
      required this.weather,
      this.temperatureUnits = TemperatureUnits.celsius})
      : super(key: key);

  Weather weather;
  TemperatureUnits temperatureUnits;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(DateFormat('EEEE').format(weather.applicableDate)),
          SvgPicture.network(
            "https://www.metaweather.com/static/img/weather/${weather.weatherStateAbbr}.svg",
            fit: BoxFit.cover,
            height: 60,
          ),
          Text(
            celciusToFahrenheit(weather.minTemp, temperatureUnits) +
                "/" +
                celciusToFahrenheit(weather.maxTemp, temperatureUnits),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
