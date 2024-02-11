import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/src/bloc/CitiesBlock.dart';
import 'package:weather/src/models/Temperatures.dart';
import 'package:weather/src/utils/TextStyles.dart';
import 'package:weather/src/widgets/DayWeather.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.title});

  final String title;

  @override
  State<DetailScreen> createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  void removeCity(String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String>? cities = prefs.getStringList('cities');

    cities!
        .removeWhere((element) => element.toLowerCase() == city.toLowerCase());

    await prefs.setStringList('cities', cities);

    citiesBloc.removeCity(city);

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Temperatures temperatures =
        ModalRoute.of(context)!.settings.arguments as Temperatures;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(12, 123, 240, 1),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "Details",
                      style: manropeText(20, FontWeight.w500, Colors.white),
                    ),
                  ),

                   if ( temperatures.location.name.toLowerCase() != "toronto" )

                     Container(
                       alignment: Alignment.center,
                       child: GestureDetector(
                         onTap: () => removeCity(temperatures.location.name),
                         child: Container(
                           height: 30,
                           width: 30,
                           decoration: const BoxDecoration(
                             image: DecorationImage(
                               image: AssetImage("assets/images/trash.png"),
                             ),
                           ),
                         ),
                       ),
                     ),

                  Container(
                    width: 100,
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/return_icon.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              temperatures.location.name,
              style: manropeText(27, FontWeight.w500, Colors.white),
            ),
            Expanded(
              child: ListView(
                children: [
                  Center(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Container(
                      width: 120,
                      height: 120,
                      margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 84, 110, 228),
                        image: DecorationImage(
                          image: NetworkImage(
                            "http:${temperatures.forecast.forecastday[0].day.condition.icon}",
                          ),
                          scale: 0.85,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10, bottom : 0)),
                  Center(
                  child: Text(
                    "${double.parse(temperatures.forecast.forecastday[0].day.mintempC).toInt()}/"
                        "${double.parse(temperatures.forecast.forecastday[0].day.maxtempC).toInt()} \u00B0 C",
                    style: manropeText(17.4, FontWeight.w500, Colors.white70),
                  ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        ...temperatures.forecast.forecastday.map(
                          (e) => DayWeather(forecastday: e),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
