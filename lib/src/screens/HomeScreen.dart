import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather/src/bloc/CitiesBlock.dart';
import 'package:weather/src/widgets/AddCity.dart';
import 'package:weather/src/widgets/CityWeather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool bottomSheet = false;

  void toggleBottomSheet() {
    setState(() {
      bottomSheet = !bottomSheet;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(12, 123, 240, 1),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              top: 0,
              left: 0,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              duration: const Duration(milliseconds: 250),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 75.0,
                          width: 75.0,
                          margin: const EdgeInsets.only(top: 15.0, bottom: 15),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/weather_icon.png"),
                            ),
                          ),
                        ),
                        const Text(
                          'brilliant weather',
                          style: TextStyle(
                            fontFamily: "manrope",
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    Expanded(
                      child: CustomStreamBuilder(
                        stream: citiesBloc.behaviorSubject,
                        dataBuilder: (context, data) {
                          return Container(
                            padding: const EdgeInsets.only(bottom: 70),
                              child: ListView(
                            children: [
                              ...(data ?? []).map(
                                (e) => CityWeather(temperatures: e),
                              ),
                            ],
                              ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              bottom: bottomSheet ? -30 : -MediaQuery.of(context).size.height,
              left: 0,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.8,
              duration: const Duration(milliseconds: 600),
              child: AddCity( toggle: ()=> toggleBottomSheet() ),
            )
          ],
        ),
      ),
      floatingActionButton: !bottomSheet
          ? FloatingActionButton(
              onPressed: () => toggleBottomSheet(),
              backgroundColor: const Color.fromRGBO(84, 112, 228, 1),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            )
          : null,
    );
  }
}
