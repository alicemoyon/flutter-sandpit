import 'package:flutter/material.dart';
import 'aq_screen.dart';

class SecondRoute extends StatelessWidget {

  SecondRoute(name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('hello'),//name?? 'default value'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}