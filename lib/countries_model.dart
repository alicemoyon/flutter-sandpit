
import 'package:flutter/material.dart';
import 'country.dart';

class CountriesModel extends ChangeNotifier {

  //TODO find a more elegant way to deal with no country tapped initially
  Country lastTappedCountry = Country('z', 0, 0, 0, "No country tapped yet");

  void tapCountry(Country country){
    lastTappedCountry = country;
    notifyListeners();
  }

}