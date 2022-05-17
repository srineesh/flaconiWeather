// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../bloc/weather_bloc.dart';
import '../constants.dart';
import '../models/weather.dart';
import '../utils.dart';

class WeatherDetailPage extends StatelessWidget {
  WeatherDetailPage(this.weather,
      {Key? key, this.temperatureUnits = TemperatureUnits.celsius})
      : super(key: key);
  List<Weather> weather;
  TemperatureUnits temperatureUnits;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlaconiColors.commonColor,
      appBar: AppBar(
        backgroundColor: FlaconiColors.commonColor,
        title: const Text(weatherForecastLabel),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemCount: weather.length,
          separatorBuilder: (context, index) => const Divider(
                color: Colors.white,
              ),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: SvgPicture.network(
                "https://www.metaweather.com/static/img/weather/${weather[index].weatherStateAbbr}.svg",
                fit: BoxFit.cover,
                width: 40,
              ),
              title: Text(
                DateFormat('EEEE').format(weather[index].applicableDate),
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                weather[index].weatherStateName,
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              trailing: Text(
                "+" +
                    celciusToFahrenheit(
                        weather[index].minTemp, temperatureUnits) +
                    "\u00B0" +
                    " / " +
                    celciusToFahrenheit(
                        weather[index].maxTemp, temperatureUnits),
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
            );
          }),
    );
  }
}
