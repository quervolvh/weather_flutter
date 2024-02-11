
class Current {
  String tempC;
  String tempF;

  Current({
    required this.tempC,
    required this.tempF,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    tempC: "${json["temp_c"]}",
    tempF: "${json["temp_f"]}",
  );

  Map<String, dynamic> toJson() => {
    "temp_c": tempC.toString(),
    "temp_f": tempF.toString()
  };
}
