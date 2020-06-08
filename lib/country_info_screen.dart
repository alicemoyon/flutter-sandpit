import 'package:flutter/material.dart';

import 'country.dart';

class CountryInfoScreen extends StatelessWidget {

  CountryInfoScreen(this.country);

  final Country country;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: FlatButton(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Country Information"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(country.name ?? "name not available"),
            Text(country.code),
            Text("${country.count}"),
            Text("${country.locations}"),
          ],
        ),
      ),
    );
  }
}
