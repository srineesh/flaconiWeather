import 'bloc/weather_bloc.dart';

String celciusToFahrenheit(double value, TemperatureUnits units) {
  if (units == TemperatureUnits.celsius) {
    final double val = (value * 1.8) + 32;
    return val.toStringAsFixed(2) + "°F";
  } else {
    return value.toStringAsFixed(2) + "°C";
  }
}
