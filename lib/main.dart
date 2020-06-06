import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttersandpit/flavourcard.dart';
import 'package:fluttersandpit/homescreen.dart';

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


class WeatherScreen extends StatelessWidget {
  final Future<String> _myFuture = Future.delayed(
    Duration(seconds: 10),
    () => 'Sunshine',
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _myFuture,
      initialData: "initial data",
      //ignore: missing_return,
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
                    child: Text("fetching the weather"),
                  ),
                  CircularProgressIndicator(),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            return Center(child: Text(snapshot.data));
          default: return Center(child: Text(snapshot.data));
        }
      },
    );
  }

  // BUTTON CODE - ADD LATER - FIND A WAY TO TRIGGER FUTUREBUILDER FROM THIS BUTTON
//    return FlatButton(
//      child: Text(
//        'Check Weather',
//        style: TextStyle(fontSize: 20),
//      ),
//      onPressed: () {
//        Future.delayed(
//          Duration(seconds: 3),
//          () => 'Sunshine',
//        );
//      },
//    );
//  }

//  @override
//  Widget build(BuildContext context) {
//    return FlatButton(
//      child: Text(
//        'Check Weather',
//        style: TextStyle(fontSize: 20),
//      ),
//      onPressed: () {
//        Future.delayed(
//          Duration(seconds: 3),
//              () => 'Sunshine',
//        );
//      },
//    );
//  }
}

class BuyScreen extends StatelessWidget {
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

  //TODO this works but what I'm trying to do is to only show the cards once the images are fully loaded.
  //TODO I tried without the future.delayed, turning _makeFlavourCardsList() into an async function returning
  //TODO a future into _flavourCards but that doesn't seem to wait until the image is loaded.
  //TODO also....why the green lines and info msg??
  final Future<List<FlavourCard>> _flavourCards = Future.delayed(
    Duration(seconds: 7),
    () => _makeFlavourCardsList(),
  );

// Build the list of FlavourCard widgets from the Map
  static List<FlavourCard> _makeFlavourCardsList() {
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

  // Display the cards once they are all ready
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FlavourCard>>(
      future: _flavourCards,
      builder:
          (BuildContext context, AsyncSnapshot<List<FlavourCard>> snapshot) {
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
              itemBuilder: (BuildContext context, int index) =>
                  snapshot.data[index],
            );
          default: return Text("catch all");
        }
      },
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
