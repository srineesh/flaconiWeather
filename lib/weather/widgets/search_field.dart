import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/weather_bloc.dart';
import '../constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required TextEditingController searchController,
  })  : _searchController = searchController,
        super(key: key);

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29.5),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          border: InputBorder.none,
          hintText: widgetSearchText,
        ),
        onSubmitted: (text) {
          if (_searchController.text.isNotEmpty) {
            context
                .read<WeatherBloc>()
                .add(SearchWeatherEvent(_searchController.text.trim()));
          }
        },
      ),
    );
  }
}
