import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';

class TempUnitSwitch extends StatefulWidget {
  @override
  TempUnitSwitchClass createState() => TempUnitSwitchClass();
}

class TempUnitSwitchClass extends State {
  bool isSwitched = false;
  var textValue = "°F";

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      context
          .read<WeatherBloc>()
          .add(ToggleTempUnitsEvent(TemperatureUnits.celsius));
      setState(() {
        isSwitched = true;
        textValue = "°C";
      });
    } else {
      context
          .read<WeatherBloc>()
          .add(ToggleTempUnitsEvent(TemperatureUnits.fahrenheit));
      setState(() {
        isSwitched = false;
        textValue = "°F";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Transform.scale(
          scale: 1.5,
          child: Switch(
            onChanged: toggleSwitch,
            value: isSwitched,
            activeColor: Colors.blue,
            activeTrackColor: Colors.yellow,
            inactiveThumbColor: Colors.redAccent,
            inactiveTrackColor: Colors.orange,
          )),
      Text(
        textValue,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      )
    ]);
  }
}
