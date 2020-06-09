import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            Image.asset(
//              "assets/images/danieloberg3sl9ubYInounsplash.jpg",
//            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "So many flavours to choose from...",
                style: TextStyle(fontSize: 18.0, fontFamily: 'Roboto'),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "Pick your favourite!",
              style: TextStyle(fontSize: 18.0, fontFamily: 'Roboto'),
              textAlign: TextAlign.center,
            ),
            Center(child: IceCreamSelection()),
            //TODO pass the state to this so it changes with the dd selection
          ],
        ),
      ),
    ));
  }
}

class IceCreamSelection extends StatefulWidget {
  IceCreamSelection({Key key}) : super(key: key);

  @override
  IceCreamSelectionState createState() => IceCreamSelectionState();
}

class IceCreamSelectionState extends State<IceCreamSelection> {
  static List<String> _flavours = [
    "strawberry",
    "vanilla",
    "blueberry",
    "lime",
    "chocolate",
    "pistachio",
    "coconut",
    "mango",
    "raspberry",
    "orange",
    "banana",
    "toffee",
    "coffee",
  ];
  String _selectedFlavour = _flavours[0];

  _displaySelection(String flavour) {
    setState(() {
      _selectedFlavour = flavour;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DropdownButton<String>(
          value: _selectedFlavour,
          items: _flavours.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: TextStyle(fontSize: 18.0, fontFamily: 'Roboto')),
            );
          }).toList(),
          onChanged: _displaySelection,
        ),
        Image.asset(
            "assets/images/$_selectedFlavour.jpg"),
      ],
    );
  }
}

