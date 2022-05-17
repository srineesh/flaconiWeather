// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      id: json['id'] as int,
      weatherStateName: json['weather_state_name'] as String,
      weatherStateAbbr: json['weather_state_abbr'] as String,
      windDirectionCompass: $enumDecode(
          _$WindDirectionCompassEnumMap, json['wind_direction_compass'],
          unknownValue: WindDirectionCompass.unknown),
      created: DateTime.parse(json['created'] as String),
      applicableDate: DateTime.parse(json['applicable_date'] as String),
      minTemp: (json['min_temp'] as num).toDouble(),
      maxTemp: (json['max_temp'] as num).toDouble(),
      theTemp: (json['the_temp'] as num).toDouble(),
      windSpeed: (json['wind_speed'] as num).toDouble(),
      windDirection: (json['wind_direction'] as num).toDouble(),
      airPressure: (json['air_pressure'] as num).toDouble(),
      humidity: json['humidity'] as int,
      visibility: (json['visibility'] as num).toDouble(),
      predictability: json['predictability'] as int,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'weather_state_name': instance.weatherStateName,
      'weather_state_abbr': instance.weatherStateAbbr,
      'wind_direction_compass':
          _$WindDirectionCompassEnumMap[instance.windDirectionCompass],
      'created': instance.created.toIso8601String(),
      'applicable_date': instance.applicableDate.toIso8601String(),
      'min_temp': instance.minTemp,
      'max_temp': instance.maxTemp,
      'the_temp': instance.theTemp,
      'wind_speed': instance.windSpeed,
      'wind_direction': instance.windDirection,
      'air_pressure': instance.airPressure,
      'humidity': instance.humidity,
      'visibility': instance.visibility,
      'predictability': instance.predictability,
    };

const _$WindDirectionCompassEnumMap = {
  WindDirectionCompass.north: 'N',
  WindDirectionCompass.northEast: 'NE',
  WindDirectionCompass.east: 'E',
  WindDirectionCompass.southEast: 'SE',
  WindDirectionCompass.south: 'S',
  WindDirectionCompass.southWest: 'SW',
  WindDirectionCompass.west: 'W',
  WindDirectionCompass.northWest: 'NW',
  WindDirectionCompass.unknown: 'unknown',
};
