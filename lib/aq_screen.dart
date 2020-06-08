import 'package:flutter/material.dart';

import 'networking.dart';

var url = 'https://api.openaq.org/v1/countries?limit=1';

class AqScreen extends StatelessWidget {

  static Future<String> getCountries() async {
    NetworkHelper nh = NetworkHelper(url);

    var countryData = await nh.getData();
    String countryName = countryData['results'][0]['name'];
    return countryName;
  }

  final Future<String> countryName = getCountries();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: countryName,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasError)
          return Text("Error: ${snapshot.error.toString()}");
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("No connection");
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("fetching the flavour cards"),
                  ),
                  CircularProgressIndicator(),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView(
              children: <Widget>[
                Text(snapshot.data),
              ],
            );
          default:
            return Text("something else happened",);
        }
      }
    );
  }
}
