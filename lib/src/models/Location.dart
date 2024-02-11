
class Location {
  String name;
  String region;
  String country;
  String lat;
  String lon;
  String tzId;
  String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"],
    region: json["region"],
    country: json["country"],
    lat: "${json["lat"]}",
    lon: "${json["lon"]}",
    tzId: json["tz_id"],
    localtime: json["localtime"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "region": region,
    "country": country,
    "lat": lat.toString(),
    "lon": lon.toString(),
    "tz_id": tzId,
    "localtime": localtime,
  };
}
