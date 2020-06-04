import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttersandpit/flavourcard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainWidget(),
      title: "My favourite ice creams",
    );
  }
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: Center(
              child: FaIcon(
            FontAwesomeIcons.iceCream,
          )),
          title: Text("Home"),
          backgroundColor: Colors.teal,
        ),
        //drawer: MyNavigationDrawer(),
        body: TabBarView(
          children: <Widget>[
            HomeScreen(),
            WeatherScreen(),
            BuyScreen(),
          ],
        ),
        bottomNavigationBar: myBottomNavBar(),
      ),
    );
  }
}

class IceCreamDropdown extends StatefulWidget {
  IceCreamDropdown({Key key}) : super(key: key);

  @override
  IceCreamDropdownState createState() => IceCreamDropdownState();
}

class IceCreamDropdownState extends State<IceCreamDropdown> {
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
    return DropdownButton<String>(
      value: _selectedFlavour,
      items: _flavours.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,
              style: TextStyle(fontSize: 18.0, fontFamily: 'Roboto')),
        );
      }).toList(),
      onChanged: _displaySelection,
    );
  }
}

Widget myBottomNavBar() {
  return Material(
    color: Colors.teal,
    child: TabBar(tabs: const <Widget>[
      Tab(
        icon: Icon(Icons.home),
        child: Text('Home'),
      ),
      Tab(
        icon: Icon(Icons.wb_sunny),
        child: Text('Weather'),
      ),
      Tab(
        icon: FaIcon(
          FontAwesomeIcons.iceCream,
        ),
        child: Text('Buy'),
      ),
    ]),
  );
}

Widget HomeScreen() {
  return (SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/danieloberg3sl9ubYInounsplash.jpg",
          ),
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
          Center(child: IceCreamDropdown()),
          //TODO pass the state to this so it changes with the dd selection
          Image.asset("assets/images/${IceCreamDropdownState()._selectedFlavour}.jpg"),
        ],
      ),
    ),
  ));
}

Widget WeatherScreen() {
  return Text(
    "This is the weather screen",
    textDirection: TextDirection.ltr,
  );
}

Widget BuyScreen() {
  Map<String, dynamic> flavoursInfo = {
    'strawberry': [
      'Strawberry',
      'A juicy summer flavour',
      Colors.red,
      'assets/images/strawberry.jpg',
    ],
    'raspberry': [
      'Raspberry',
      'The tastiest berry punch',
      Colors.pink,
      'assets/images/raspberry.jpg',
    ],
    'lemon': [
      'Lemon',
      'Zingy and refreshing sorbet',
      Colors.yellow,
      'assets/images/lemon.jpg',
    ],
    'mango': [
      'Mango',
      'Sweet and exotic',
      Colors.orange,
      'assets/images/mango.jpg',
    ]
  };

// Build the list of FlavourCard widgets from the Map
  final flavourCards = <FlavourCard>[];
  var keys = flavoursInfo.keys.toList();
  print(keys);

  for (num i = 0; i < keys.length; i++) {
    flavourCards.add(
      FlavourCard(flavoursInfo[keys[i]][0], flavoursInfo[keys[i]][1],
          flavoursInfo[keys[i]][2], flavoursInfo[keys[i]][3]),
    );

  }

// Display all the cards
  return ListView.builder(
    itemCount: keys.length,
    itemBuilder: (BuildContext context, int index) => flavourCards[index],
  );

}

//class Person extends StatelessWidget {
//  final String firstName;
//  final String lastName;
//  Person({this.firstName, this.lastName});
//  @override
//  Widget build(BuildContext context) {
//    return Text(
//      '$firstName $lastName',
//      textDirection: TextDirection.ltr,
//    );
//  }
//}
//
//
//
//class Cake extends StatelessWidget {
//  Widget build(BuildContext context) {
//    return Icon(
//      Icons.cake,
//      textDirection: TextDirection.ltr,
//      size: 200,
//    );
//  }
//}
