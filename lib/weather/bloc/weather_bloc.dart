import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/meta_weather_api.dart';
import '../models/weather.dart';
import '../repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

enum TemperatureUnits { fahrenheit, celsius }

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<SearchWeatherEvent>((event, emit) async {
      emit(WeatherLoadInProgress());
      try {
        List<Weather> _weathers =
            await weatherRepository.getWeatherObjects(event.queryString);
        TemperatureUnits tempUnits = await weatherRepository.findUnits();
        emit(WeatherLoadSuccess(_weathers, temperatureUnits: tempUnits));
      } on LocationNotFoundFailure catch (_) {
        emit(NoLocationFoundState());
      } on LocationIdRequestFailure catch (_) {
        emit(LocationLoadFailureState());
      } on WeatherRequestFailure catch (_) {
        emit(WeatherLoadFailureState());
      } on WeatherNotFoundFailure catch (_) {
        emit(NoWeatherFoundState());
      } catch (e) {
        emit(GenericFailureState());
      }
    });

    on<TryAgainEvent>((event, emit) async {
      emit(WeatherLoadInProgress());
      try {
        List<Weather> _weathers = await weatherRepository.tryAgainForError();
        TemperatureUnits tempUnits = await weatherRepository.findUnits();

        emit(WeatherLoadSuccess(_weathers, temperatureUnits: tempUnits));
      } on LocationNotFoundFailure catch (_) {
        emit(NoLocationFoundState());
      } on LocationIdRequestFailure catch (_) {
        emit(LocationLoadFailureState());
      } on WeatherRequestFailure catch (_) {
        emit(WeatherLoadFailureState());
      } on WeatherNotFoundFailure catch (_) {
        emit(NoWeatherFoundState());
      } catch (e) {
        emit(GenericFailureState());
      }
    });

    on<RefreshWeatherEvent>((event, emit) async {
      emit(WeatherLoadInProgress());
      try {
        List<Weather> _weathers = await weatherRepository.refreshWeather();
        TemperatureUnits tempUnits = await weatherRepository.findUnits();

        emit(WeatherLoadSuccess(_weathers, temperatureUnits: tempUnits));
      } on LocationNotFoundFailure catch (_) {
        emit(NoLocationFoundState());
      } on LocationIdRequestFailure catch (_) {
        emit(LocationLoadFailureState());
      } on WeatherRequestFailure catch (_) {
        emit(WeatherLoadFailureState());
      } on WeatherNotFoundFailure catch (_) {
        emit(NoWeatherFoundState());
      } catch (e) {
        emit(GenericFailureState());
      }
    });

    on<ToggleTempUnitsEvent>((event, emit) async {
      List<Weather> _weathers = [];
      if (state is WeatherLoadSuccess) {
        _weathers = (state as WeatherLoadSuccess).weather;
        weatherRepository.updateUnits(event.temperatureUnits);
        emit(WeatherLoadSuccess(_weathers,
            temperatureUnits: event.temperatureUnits));
      } else {
        emit(state);
      }
    });
  }

  final WeatherRepository weatherRepository;
}
