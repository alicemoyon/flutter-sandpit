import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:fluttersandpit/countries_model_state.dart';
import 'country.dart';

class CountriesModel extends ChangeNotifier {

  Country _lastTappedCountry;
  Country get lastTappedCountry => _lastTappedCountry;

  static StreamController<Country> get streamController => StreamController<Country>();

  void tapCountry(Country country) {
    _lastTappedCountry = country;
    //TODO this doesn't seem to add the country to the stream, or to start the stream
    streamController.add(lastTappedCountry);
    notifyListeners();
  }
}
