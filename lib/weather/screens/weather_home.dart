import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/weather_bloc.dart';
import '../constants.dart';
import '../repository/weather_repository.dart';
import '../widgets/search_field.dart';
import '../widgets/temp_switch.dart';
import '../widgets/today_weather_success.dart';
import '../widgets/weather_card.dart';
import 'weather_details.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc(WeatherRepository()),
      child: WeatherHome(),
    );
  }
}

class WeatherHome extends StatelessWidget {
  WeatherHome({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  Widget weatherErrorText(String text) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget errorWidget(ValueGetter<Future<void>> onButtonTap, String errorText) {
    return Column(
      children: [
        weatherErrorText(errorText),
        // TextButton(onPressed: onButtonTap, child: Text("test"))
        GestureDetector(
          onTap: onButtonTap,
          child: Container(
            width: 140,
            height: 50,
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xff3000ff),
            ),
            child: const Text(
              'Try Again',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: FlaconiColors.commonColor,
          body: BlocConsumer<WeatherBloc, WeatherState>(
            listener: (_, WeatherState current) {},
            buildWhen: (_, WeatherState current) {
              if (current is WeatherInitial) {
                return true;
              } else if (current is WeatherLoadInProgress) {
                return true;
              } else if (current is WeatherLoadSuccess) {
                return true;
              } else if (current is NoWeatherFoundState) {
                return true;
              } else if (current is NoLocationFoundState) {
                return true;
              } else if (current is GenericFailureState) {
                return true;
              } else if (current is LocationLoadFailureState) {
                return true;
              } else if (current is WeatherLoadFailureState) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              return RefreshIndicator(
                  onRefresh: () async {
                    if (state is WeatherLoadSuccess) {
                      return context
                          .read<WeatherBloc>()
                          .add(RefreshWeatherEvent());
                    }
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat('EEEE').format(DateTime.now()),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 35,
                                    ),
                                  ),
                                  TempUnitSwitch(),
                                ],
                              ),
                            ),
                            SearchField(searchController: _searchController),
                            if (state is WeatherInitial)
                              weatherErrorText(defaultInitialScreen),
                            if (state is WeatherLoadInProgress)
                              const Center(child: CircularProgressIndicator()),
                            if (state is WeatherLoadSuccess)
                              WeatherSuccessTodayWidget(
                                weather: state.weather[0],
                                temperatureUnits: state.temperatureUnits,
                              ),
                            if (state is WeatherLoadSuccess)
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WeatherDetailPage(state.weather,
                                                  temperatureUnits:
                                                      state.temperatureUnits)),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const <Widget>[
                                      Text(weatherForecastLabel,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                      Spacer(),
                                      Icon(Icons.arrow_forward_ios,
                                          color: Colors.white)
                                    ],
                                  ),
                                ),
                              ),
                            if (state is WeatherLoadSuccess &&
                                MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                              Expanded(
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 10, right: 10),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return WeatherCard(
                                        weather: state.weather[index],
                                        temperatureUnits:
                                            state.temperatureUnits,
                                      );
                                    },
                                    separatorBuilder: (context, i) =>
                                        const SizedBox(width: 10),
                                    itemCount: state.weather.length),
                              ),
                            if (state is NoLocationFoundState)
                              errorWidget(() async {
                                return context
                                    .read<WeatherBloc>()
                                    .add(TryAgainEvent());
                              }, noLocationFoundText),
                            if (state is NoWeatherFoundState)
                              errorWidget(() async {
                                return context
                                    .read<WeatherBloc>()
                                    .add(TryAgainEvent());
                              }, noWeatherFoundText),
                            if (state is LocationLoadFailureState)
                              errorWidget(() async {
                                return context
                                    .read<WeatherBloc>()
                                    .add(TryAgainEvent());
                              }, locationLoadFailureText),
                            if (state is WeatherLoadFailureState)
                              errorWidget(() async {
                                return context
                                    .read<WeatherBloc>()
                                    .add(TryAgainEvent());
                              }, weatherFailureText),
                            if (state is GenericFailureState)
                              errorWidget(() async {
                                return context
                                    .read<WeatherBloc>()
                                    .add(TryAgainEvent());
                              }, genericErrorText),
                          ],
                        ),
                      ),
                    ],
                  ));
            },
          )),
    );
  }
}
