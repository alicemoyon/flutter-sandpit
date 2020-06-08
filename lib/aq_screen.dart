import 'package:flutter/material.dart';

import 'networking.dart';

var url = 'https://api.openaq.org/v1/countries?limit=100';

class AqScreen extends StatelessWidget {
  static Future<List> getCountries() async {
    NetworkHelper nh = NetworkHelper(url);

    var countryData = await nh.getData();
    List countryInfo = countryData['results'];
    return countryInfo;
  }

  final Future<List> countryInfo = getCountries();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: countryInfo,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
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
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data[index]['name'] != null) {
                    return Text(snapshot.data[index]['name']);
                  } else {
                    return Text(snapshot.data[index]['code']);
                  }
                },
              );
            default:
              return Text(
                "something else happened",
              );
          }
        });
  }
}
