part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  WeatherLoadSuccess(this.weather,
      {this.temperatureUnits = TemperatureUnits.celsius});

  final List<Weather> weather;
  TemperatureUnits temperatureUnits;
}

class WeatherLoadFailureState extends WeatherState {}

class LocationLoadFailureState extends WeatherState {}

class NoLocationFoundState extends WeatherState {}

class NoWeatherFoundState extends WeatherState {}

class GenericFailureState extends WeatherState {}
