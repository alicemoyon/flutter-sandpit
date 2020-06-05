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
  //WeatherScreen(); // no need for this

  // Let's store the future in a variable and specify it's return value type:
  final Future<String> _myFuture = Future.delayed(
    Duration(seconds: 3),
    () => 'Sunshine',
  );

  /// We don't need this part, as we'll 'react' to the future completing
  /// in the builder part of the FutureBuilder
//      .then((value) {
//    print(value);
//  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _myFuture,
      // this ignore thingy is not a must,
      // just gets rid of the complaining about the switch not necessarily returning a widget
      // but we know it does, so we can just ignore like this:
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasError)
          return Text('some error occured: ${snapshot.error.toString()}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('No connection');
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            return Center(child: Text(snapshot.data));
        }
      },
    );
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

/// Moving on:
/// - Maybe try the same thing for the Listview: you can totally wrap it in a FutureBuilder,
/// and while that loads display something else (e.g. some ProgressIndicator)
///
/// - Originally, I that's pretty much what I intended with this exercise:
/// create your own futures (quickest through a dummy Future.delayed then some data loading through REST or persistence APIs)
///
/// I think next just play around with FutureBuilders as described in Exercise 5 and 6
/// and keep your futures simple enough.
///
/// (For loads of data, there might be more complex solutions, but don't worry about those.
/// For example you could have an "infinite scroll" experience
/// with data coming in maybe in a paginated fassion,
/// for that you would would not really be able to use FutureBuilders directly for every single item,
/// rather use:
/// - something called Completers or
/// - have the data in a Stream.
/// Again, don't go this way, just have 1-2 futures without the infiniteness, or load by single item effect)

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
