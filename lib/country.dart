class Country {

  final String code;
  final int count;
  final int locations;
  final int cities;
  final String name;

  Country(this.code, this.count, this.locations, this.cities, this.name);

  bool _fave = false;

  bool getFave() {
    return _fave;
  }

  void toggleFave() {
    if (_fave) {
      this._fave = false;
    } else {
      this._fave = true;
    }
  }
}