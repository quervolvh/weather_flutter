
import 'dart:convert';
import 'package:weather/src/models/Current.dart';
import 'package:weather/src/models/Forecast.dart';
import 'package:weather/src/models/Location.dart';

Temperatures temperaturesFromJson(String str) => Temperatures.fromJson(json.decode(str));

String temperaturesToJson(Temperatures data) => json.encode(data.toJson());

class Temperatures {
  Location location;
  Current current;
  Forecast forecast;

  Temperatures({
    required this.location,
    required this.current,
    required this.forecast
  });

  factory Temperatures.fromJson(Map<String, dynamic> json) => Temperatures(
    location: Location.fromJson(json["location"]),
    current: Current.fromJson(json["current"]),
    forecast: Forecast.fromJson(json["forecast"])
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "current": current.toJson(),
    "forecast": forecast.toJson()
  };
}
