
import 'package:flutter/material.dart';
import 'country.dart';

class CountriesModel extends ChangeNotifier {

  Country lastTappedCountry;

  void tapCountry(Country country){
    lastTappedCountry = country;
    notifyListeners();
  }

}