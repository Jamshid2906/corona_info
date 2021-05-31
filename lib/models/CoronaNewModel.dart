
class Welcome {
  Welcome({
    this.id,
    this.message,
    this.global,
    this.countries,
    this.date,
  });

  String id;
  String message;
  Global global;
  List<Country> countries;
  DateTime date;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["ID"],
        message: json["Message"],
        global: Global.fromJson(json["Global"]),
        countries: List<Country>.from(
            json["Countries"].map((x) => Country.fromJson(x))),
        date: DateTime.parse(json["Date"]),
      );
}

class Country {
  Country({
    this.id,
    this.country,
    this.countryCode,
    this.slug,
    this.newConfirmed,
    this.totalConfirmed,
    this.newDeaths,
    this.totalDeaths,
    this.newRecovered,
    this.totalRecovered,
    this.date,
    this.premium,
  });

  String id;
  String country;
  String countryCode;
  String slug;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;
  DateTime date;
  Premium premium;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["ID"],
        country: json["Country"],
        countryCode: json["CountryCode"],
        slug: json["Slug"],
        newConfirmed: json["NewConfirmed"],
        totalConfirmed: json["TotalConfirmed"],
        newDeaths: json["NewDeaths"],
        totalDeaths: json["TotalDeaths"],
        newRecovered: json["NewRecovered"],
        totalRecovered: json["TotalRecovered"],
        date: DateTime.parse(json["Date"]),
        premium: Premium.fromJson(json["Premium"]),
      );
}

class Premium {
  Premium();

  factory Premium.fromJson(Map<String, dynamic> json) => Premium();

  Map<String, dynamic> toJson() => {};
}

class Global {
  Global({
    this.newConfirmed,
    this.totalConfirmed,
    this.newDeaths,
    this.totalDeaths,
    this.newRecovered,
    this.totalRecovered,
    this.date,
  });

  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;
  DateTime date;

  factory Global.fromJson(Map<String, dynamic> json) => Global(
        newConfirmed: json["NewConfirmed"],
        totalConfirmed: json["TotalConfirmed"],
        newDeaths: json["NewDeaths"],
        totalDeaths: json["TotalDeaths"],
        newRecovered: json["NewRecovered"],
        totalRecovered: json["TotalRecovered"],
        date: DateTime.parse(json["Date"]),
      );
}
