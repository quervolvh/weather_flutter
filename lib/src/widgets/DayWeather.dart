import 'package:flutter/material.dart';
import 'package:weather/src/models/Forecast.dart';
import 'package:weather/src/utils/TextStyles.dart';

class DayWeather extends StatelessWidget {
  final Forecastday? forecastday;

  const DayWeather({super.key, required this.forecastday});

  String weekday(int day) {
    switch (day) {
      case 7:
        return "Sunday";
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      default:
        return "Day of week";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("i clicked on d day"),
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
                weekday(forecastday!.date.weekday.toInt()),
                style: manropeText(18.4, FontWeight.w400, null),
              ),
              Text(
                "${double.parse(forecastday!.day.mintempC).toInt()}/${double.parse(forecastday!.day.maxtempC).toInt()} \u00B0 C",
                style: manropeText(17.4, FontWeight.w500, null),
              )
            ],
          ),
        ),
      ),
    );
  }
}
