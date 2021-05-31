import 'dart:convert';

List<CoronaCountry> coronaCountryFromJson(List<dynamic> list) =>
    List<CoronaCountry>.from(list.map((x) => CoronaCountry.fromJson(x)));

String coronaCountryToJson(List<dynamic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CoronaCountry {
  CoronaCountry({
    this.country,
    this.countryCode,
    this.province,
    this.city,
    this.cityCode,
    this.lat,
    this.lon,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.active,
    this.date,
  });

  String country;
  String countryCode;
  String province;
  String city;
  String cityCode;
  String lat;
  String lon;
  int confirmed;
  int deaths;
  int recovered;
  int active;
  DateTime date;

  factory CoronaCountry.fromJson(Map<String, dynamic> json) => CoronaCountry(
        country: json["Country"],
        countryCode: json["CountryCode"],
        province: json["Province"],
        city: json["City"],
        cityCode: json["CityCode"],
        lat: json["Lat"],
        lon: json["Lon"],
        confirmed: json["Confirmed"],
        deaths: json["Deaths"],
        recovered: json["Recovered"],
        active: json["Active"],
        date: DateTime.parse(json["Date"]),
      );
}
