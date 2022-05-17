// ignore_for_file: must_be_immutable

part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

//This is responsible for searching the weather
class SearchWeatherEvent extends WeatherEvent {
  final String queryString;
  SearchWeatherEvent(this.queryString);
}

///This is responsible for refreshing the weather
class RefreshWeatherEvent extends WeatherEvent {}

//This is for checking the initial event and automatically call the api if there is a previous location stored.
class InitialEvent extends WeatherEvent {}

//This is called when [try again] button is clicked.
class TryAgainEvent extends WeatherEvent {}

//This event is respionsible for toggling the temp units
class ToggleTempUnitsEvent extends WeatherEvent {
  ToggleTempUnitsEvent(this.temperatureUnits);
  TemperatureUnits temperatureUnits;
}
