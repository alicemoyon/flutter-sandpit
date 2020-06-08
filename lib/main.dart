import 'package:flutter/material.dart';
import 'package:fluttersandpit/weather_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttersandpit/home_screen.dart';
import 'aq_screen.dart';
import 'buy_screen.dart';

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
        icon: FaIcon(FontAwesomeIcons.globe,),
        child: Text('Country'),
      ),
    ]),
  );
}




