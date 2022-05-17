import '../bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/weather.dart';
import '../utils.dart';

class WeatherSuccessTodayWidget extends StatelessWidget {
  const WeatherSuccessTodayWidget(
      {Key? key,
      required this.weather,
      this.temperatureUnits = TemperatureUnits.celsius})
      : super(key: key);

  final Weather weather;
  final TemperatureUnits temperatureUnits;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.85,
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(weather.weatherStateName, style: const TextStyle(fontSize: 20)),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              child: SvgPicture.network(
                "https://www.metaweather.com/static/img/weather/${weather.weatherStateAbbr}.svg",
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(celciusToFahrenheit(weather.theTemp, temperatureUnits),
              style: const TextStyle(fontSize: 50)),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Humidity: ${weather.humidity}",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.start),
                Text('Pressure: ${weather.airPressure}',
                    style: const TextStyle(fontSize: 15)),
                Text("Wind: ${weather.windSpeed.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 15)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
