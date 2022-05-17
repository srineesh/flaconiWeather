import '../bloc/weather_bloc.dart';

import '../../services/meta_weather_api.dart';
import '../../services/preferences.dart';
import '../constants.dart';
import '../models/location.dart';
import '../models/weather.dart';

class WeatherRepository {
  WeatherRepository({MetaWeatherApiClient? apiClient, Preferences? preferences})
      : _weatherApiClient = apiClient ?? MetaWeatherApiClient(),
        _preferences = preferences ?? Preferences();
  final MetaWeatherApiClient _weatherApiClient;
  final Preferences _preferences;

  /// It takes a place name, saves it to shared preferences, gets the woeid for that place name, saves
  /// the woeid to shared preferences, and then gets the weather for that woeid
  ///
  /// Args:
  ///   placeName (String): The name of the place you want to search for.
  ///
  /// Returns:
  ///   A Future<List<Weather>>
  Future<List<Weather>> getWeatherObjects(String placeName) async {
    try {
      _preferences.setStringValue(searchTermKey, placeName);
      Location val = await _weatherApiClient.locationSearch(placeName);
      _preferences.setIntValue(woeidKey, val.woeid);
      List<Weather> val2 = await _weatherApiClient.getWeather(val.woeid);
      return val2;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Weather>> tryAgainForError() async {
    try {
      String storedSearchTerm =
          await _preferences.retrieveString(searchTermKey) ?? "";
      Location val = await _weatherApiClient.locationSearch(storedSearchTerm);
      _preferences.setIntValue(woeidKey, val.woeid);
      List<Weather> val2 = await _weatherApiClient.getWeather(val.woeid);
      return val2;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Weather>> refreshWeather() async {
    try {
      int? val = await _preferences.retrieveWoeid(woeidKey);
      if (val != null) {
        List<Weather> val2 = await _weatherApiClient.getWeather(val);
        return val2;
      } else {
        throw LocationNotFoundFailure();
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<TemperatureUnits> findUnits() async {
    String? temp = await _preferences.retrieveString(tempUnitsKey);
    if (temp == null || temp == celsiusValue) {
      return TemperatureUnits.celsius;
    } else {
      return TemperatureUnits.fahrenheit;
    }
  }

  void updateUnits(TemperatureUnits tempUnits) async {
    if (tempUnits == TemperatureUnits.celsius) {
      _preferences.setStringValue(tempUnitsKey, celsiusValue);
    } else {
      _preferences.setStringValue(tempUnitsKey, fahrenheitValue);
    }
  }
}
