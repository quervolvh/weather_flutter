
import 'dart:convert';

import 'package:custom_bloc/custom_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/src/models/Temperatures.dart';
import 'package:weather/src/service/HTTP.dart';

class CitiesBloc with BaseBloc<List<Temperatures>?, String> {
  List<Temperatures>? temperatures;

  Map<String, dynamic> outputQueryParam(String city) {
    return ({
      "key": "7bee842817fe479abd321518240702",
      "q": city,
      "aqi": "no",
      "days": "7",
      "alerts": "no"
    });
  }

  CitiesBloc() {
    fetchCities();
  }

  void fetchCities() async {
    setAsLoading();

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final List<String>? cities = prefs.getStringList('cities');

      var futures = await Future.wait([
        HTTP.request("/v1/forecast.json", outputQueryParam("toronto"), "get"),
        ...(cities ?? []).map((city) => HTTP.request(
            "/v1/forecast.json", outputQueryParam(city.toLowerCase()), "get"))
      ]);

      for (var i = 0; i < futures.length; i++) {
        if (futures[i].body != null) {
          if (i == 0) {
            temperatures = [
              Temperatures.fromJson(json.decode(futures[i].body))
            ];
          } else {
            temperatures
                ?.add(Temperatures.fromJson(json.decode(futures[i].body)));
          }
        }
      }

      addToModel(temperatures);
    } catch (err) {
      print(err);
      addToError('Could not fetch data');
    }
  }

  void removeCity(String city) async {
    temperatures!
        .removeWhere((element) => element.location.name.toLowerCase() == city.toLowerCase());
    addToModel(temperatures);
  }

  void addCity(String city) async {

    try {
      var future = await HTTP.request(
          "/v1/forecast.json", outputQueryParam(city), "get");

      var temperature = Temperatures.fromJson(json.decode(future.body));

      if (temperatures!.isEmpty) {
        temperatures = [temperature];
      } else {
        var toronto = (temperatures ?? [])[0];

        (temperatures ?? []).removeAt(0);

        if (toronto.location.name.toLowerCase() == "toronto") {
          temperatures = [ toronto, temperature, ...(temperatures ?? [])];
        } else {
          temperatures = [ temperature, ...(temperatures ?? [])];
        }
      }

      addToModel(temperatures);
    } catch (err) {
      print(err);
    }

  }

  resetData() {
    temperatures = null;
    setAsNoContent();
  }

  invalidate() {
    invalidateBaseBloc();
  }

  dispose() {
    disposeBaseBloc();
  }
}

final citiesBloc = CitiesBloc();
