import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttersandpit/flavourcard.dart';
import 'package:fluttersandpit/homescreen.dart';
import 'aq_screen.dart';
import 'buyscreen.dart';

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
      length: 4,
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
            AqScreen(),
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
      Tab(
        icon: Icon(Icons.map),
        child: Text('countries'),
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
}

