import 'package:flutter/material.dart';
import 'package:fluttersandpit/flavourcard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

class HomeScreen extends StatelessWidget {
  HomeScreen();

  @override
  Widget build(BuildContext context) {
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
            Image.asset(
                "assets/images/${IceCreamDropdownState()._selectedFlavour}.jpg"),
          ],
        ),
      ),
    ));
  }
}

class WeatherScreen extends StatelessWidget {
  WeatherScreen();

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Check Weather',
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        /// This is actually correct: you wait for 3s,
        /// then return some value and print that
        ///
        /// So basically, you have your Future ready to use,
        /// e.g. in a FutureBuilder... See next commit
        Future.delayed(
          Duration(seconds: 3),
          () => 'Sunshine',
        ).then((value) {
          print(value);
        });
      },
    );
  }
}

class BuyScreen extends StatelessWidget {
  // Constructor
  BuyScreen();

  // Map containing all the flavours info: Name, Description, Color and Image Location
  static Map<String, dynamic> flavoursInfo = {
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
    ],
    'chocolate': [
      'Chocolate',
      'A comforting classic',
      Colors.brown,
      'assets/images/chocolate.jpg',
    ],
    'mint': [
      'Mint',
      'Fresh herbal flavours',
      Colors.teal,
      'assets/images/mint.jpg',
    ]
  };

// Build the list of FlavourCard widgets from the Map

  List<FlavourCard> _makeFlavourCardsList() {
    var flavourCards = <FlavourCard>[];
    var keys = flavoursInfo.keys.toList();
    for (num i = 0; i < keys.length; i++) {
      flavourCards.add(
        FlavourCard(flavoursInfo[keys[i]][0], flavoursInfo[keys[i]][1],
            flavoursInfo[keys[i]][2], flavoursInfo[keys[i]][3]),
      );
    }
    return flavourCards;
  }

//  Future<List<FlavourCard>> getFlavourCardsList() async {
//    flavourCards = await makeFlavourCardsList();
//    return flavourCards;
//  }

// Display all the cards
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: flavoursInfo.length,
      itemBuilder: (BuildContext context, int index) =>
          _makeFlavourCardsList()[index],
    );
  }
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
