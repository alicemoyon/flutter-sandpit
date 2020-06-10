import 'package:flutter/material.dart';

import 'country.dart';
import 'weather_screen.dart';

class CountriesModel extends ChangeNotifier {
  //TODO find a more elegant way to deal with no country tapped initially

  /// Ah, yes, the evergreen question:
  /// Is it safe to leave a variable (or init with) null?
  /// I follow the 'yes it is' school,
  /// probably because I started with C++ and there you can't avoid it, therefore
  /// it seems less scary to me.
  ///
  /// Anyway, so the feeling is right:
  /// the creation of this dummy Country below is not that elegant.
  ///
  /// If we absolutely wanted an object with a specific state that indicates that it
  /// HAS_NOT_BEEN_SET,
  /// we could use a dedicated factory method.
  ///
  /// But, let's do something else here, so instead
  //Country lastTappedCountry = Country('z', 0, 0, 0, "No country tapped yet");

  // have this:
  Country _lastTappedCountry;

  // How to access it from the client/called side though?
  // Because there are two ways.

  /// Option 1) getter function:
  ///
  /// WARNING: you shouldn't use this in the end,
  /// serves only demonstration purposes, see the notes inside
  /// to signal this, we can use the deprecated notation like this:
  @deprecated
  Country getLastTappedCountry() {
    /// And, since the variable exposed could be null, lets do this:
    assert(_lastTappedCountry != null,
        'Make sure to set lastTappedCountry before accessing it');

    return _lastTappedCountry;

    /// Asserts are great safety checks.
    ///
    /// We could just
    /// if (lastTappedCountry != null) {...}
    /// on the client side,
    /// but what if someone comes along and forgets to do that later?
    /// The assertion above could guard against exactly that.
    ///
    /// However, assertions like the above are mainly meant for things to pick-up on
    /// and guard against while you are developing, not so much handling a valid case/state/etc...
    /// So here, we're probably better off with the if (lastTappedCountry != null) {...}
    ///
    /// And incidentally that also means, that we don't need the getter to be a function,
    /// so let's do this instead:
  }

  /// Option 2) getter variable:
  /// this is actually the standard way in Dart to make a variable read-only
  ///
  /// OK, so we'll go with this, but let's not forget the null-check,
  /// see [Weather.showAlertDialog] <-- NOTE: you can do cross-references in comments!!
  ///
  Country get lastTappedCountry => _lastTappedCountry;

  // and then have dedicated setters in case we need:
  void tapCountry(Country country) {
    _lastTappedCountry = country;
    notifyListeners();
  }
}
