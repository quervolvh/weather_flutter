
import 'package:weather/src/models/Condition.dart';

class Day {
  String maxtempC;
  String maxtempF;
  String mintempC;
  String mintempF;
  Condition condition;

  Day({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.condition,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    maxtempC: "${json["maxtemp_c"]}",
    maxtempF: "${json["maxtemp_f"]}",
    mintempC: "${json["mintemp_c"]}",
    mintempF: "${json["mintemp_f"]}",
    condition: Condition.fromJson(json["condition"]),
  );

  Map<String, dynamic> toJson() => {
    "maxtemp_c": maxtempC.toString(),
    "maxtemp_f": maxtempF.toString(),
    "mintemp_c": mintempC.toString(),
    "mintemp_f": mintempF.toString(),
    "condition": condition.toJson(),
  };

}