import 'package:flutter/material.dart';
import 'package:weather/src/models/Temperatures.dart';
import 'package:weather/src/utils/TextStyles.dart';

class CityWeather extends StatelessWidget {
  final Temperatures? temperatures;

  const CityWeather({super.key, required this.temperatures});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed("/details", arguments: temperatures),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Container(
          padding:
              const EdgeInsets.only(top: 27, bottom: 27, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                temperatures!.location.name,
                style: manropeText(18.4, FontWeight.w400, null),
              ),
              Text(
                "${double.parse(temperatures!.forecast.forecastday[0].day.mintempC).toInt()}/${double.parse(temperatures!.forecast.forecastday[0].day.maxtempC).toInt()} \u00B0 C",
                style: manropeText(17.4, FontWeight.w500, null),
              )
            ],
          ),
        ),
      ),
    );
  }
}
