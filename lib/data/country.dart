class Country {
  final String name;
  final String code;
  final int locations;
  final int cities;
  final int count;

  Country({
    this.name,
    this.code,
    this.locations,
    this.cities,
    this.count,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json["name"],
      code: json["code"],
      locations: json["locations"],
      cities: json["cities"],
      count: json["count"],
    );
  }
}
