import 'package:flutter/material.dart';
import 'flavourcard.dart';

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
  //final Future<List<FlavourCard>> _flavourCards = await _makeFlavourCardsList();

  static Future<List<FlavourCard>> getFlavourCardsList() async {
    List<FlavourCard> flavourCards = await _makeFlavourCardsList();
    return flavourCards;
  }

// Build the list of FlavourCard widgets from the Map
  static Future<List<FlavourCard>> _makeFlavourCardsList() async {
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

  final Future<List<FlavourCard>> _flavourCards = getFlavourCardsList();

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