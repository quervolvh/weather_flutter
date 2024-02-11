import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/src/bloc/CitiesBlock.dart';
import 'package:weather/src/utils/TextStyles.dart';

class AddCity extends StatefulWidget {
  const AddCity({super.key, required this.toggle});
  final VoidCallback toggle;

  @override
  State<AddCity> createState() => AddCityState();
}

class AddCityState extends State<AddCity> {

  void addCity(String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String>? cities = prefs.getStringList('cities');

    if ((cities ?? [])!.contains(city)) {
      const snackBar = SnackBar(
        content: Text('City already on list!'),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      return;
    }

    await prefs.setStringList('cities', <String>[city, ...(cities ?? [])]);

    citiesBloc.addCity(city);

    widget.toggle();
  }

  List<String> citiesList = [
    "Edmonton",
    "Winnipeg",
    "Fredericton",
    "Halifax",
    "Charlottetown",
    "Quebec",
    "Regina",
    "Yellowknife",
    "Iqaluit",
    "Salinas",
    "Salisbury",
    "Salou",
    "Salt Lake City",
    "Salta",
    "Salter Path",
    "Salvador",
    "Salzburg",
    "San Angelo",
    "Lucca",
    "Lucerne",
    "Lugano",
    "Luganville",
    "Lund",
    "Lusaka",
    "Luxembourg",
    "Luxor",
    "Lyon",
    "Warsaw",
    "Warth",
    "Washington",
    "Water Mill",
    "Waterford",
    "Watertown"
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: const Color.fromRGBO(84, 112, 228, 1),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        padding:
            const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add City",
                  style: manropeText(20, FontWeight.w500, Colors.white),
                ),
                GestureDetector(
                  onTap: () => widget.toggle(),
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
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Expanded(
              child: ListView(
                children: [
                  ...citiesList.map(
                    (e) => GestureDetector(
                      onTap: () => addCity(e),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          e,
                          style: manropeText(
                            19,
                            FontWeight.w500,
                            const Color.fromRGBO(255, 255, 255, 0.8),
                          ),
                        ),
                      ),
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
}
