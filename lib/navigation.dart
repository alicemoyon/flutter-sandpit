import 'package:flutter/material.dart';
import 'aq_screen.dart';

class SecondRoute extends StatelessWidget {
  final String name;
  final String code;
  final int locations;
  final int cities;
  final int count;

  SecondRoute(
    this.name,
    this.code,
    this.locations,
    this.cities,
    this.count,
  );

  //name = this.name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name ?? 'NAME N/A'), //name?? 'default value'),
        backgroundColor: Color(0xFFFFFFF),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
                "\nCode: $code\n"
                "\n Locations: $locations\n"
                "\n Cities: $cities\n"
                "\n Count: $count\n",
                style: TextStyle(fontSize: 30)),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!', style: TextStyle(fontSize: 30)),
            ),
          ],
        ),
      ),
    );
  }
}
