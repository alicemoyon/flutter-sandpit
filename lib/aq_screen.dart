import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'navigation.dart';

import 'dart:convert';

class AqScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CountryList());
  }
}

///////////////
class Resource<T> {
  final String url;
  T Function(Response response) parse;

  Resource({this.url, this.parse});
}

class Webservice {
  Future<T> load<T>(Resource<T> resource) async {
    final response = await http.get(resource.url);
    if (response.statusCode == 200) {
      //return resource.parse(response);
      var parsed = resource.parse(response);
      print("parsed");
      return parsed;
      ////////
    }
    else {
      throw Exception('Failed to load data!');
    }
  }
}

////////////////////////
//Navigation
//class SecondRoute extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Second Route"),
//      ),
//      body: Center(
//        child: RaisedButton(
//          onPressed: () {
//            Navigator.pop(context);
//          },
//          child: Text('Go back!'),
//        ),
//      ),
//    );
//  }
//}

//Navigation^
class CountryListState extends State<CountryList> {
  //////ALERT
  void _showDialog(
    array,
    name,
    code,
    locations,
    cities,
    count,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(name),
          content: new Text("Code: $code"
              "\n Locations: $locations"
              "\n Cities: $cities"
              "\n Count: $count"),
          actions: <Widget>[
            //
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  ////Alert ^

  List<Country> _countries = List<Country>();

  @override
  void initState() {
    super.initState();
    _populateCountries();
  }

  void _populateCountries() {
    Webservice().load(Country.all).then((countries) => {
          setState(() => {_countries = countries})
        });
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
        title: RaisedButton(
      //dialog box
//      onPressed: () => _showDialog(
//        _countries,
//        _countries[index].name,
//          _countries[index].code,
//          _countries[index].locations,
//          _countries[index].cities,
//        _countries[index].count,
//      ),
      // navigation
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondRoute(
            _countries[index].name,
            _countries[index].code,
            _countries[index].locations,
            _countries[index].cities,
            _countries[index].count,
          )),
        );
      },
      child: Text(_countries[index].name ?? 'NAME N/A',
          style: TextStyle(fontSize: 18)),
    ));
  }

/////////////////////Build

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: _countries.length,
      itemBuilder: _buildItemsForListView,
    ));
  }
}

///////////////////////////////////////////////
class CountryList extends StatefulWidget {
  @override
  createState() => CountryListState();
}

/////////////////////

class Country {
  final String name;
  final String code;
  final int locations;
  final int cities;
  final int count;

  Country({
    this.name,
    this.code,
    this.locations,
    this.cities,
    this.count,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json["name"],
      code: json["code"],
      locations: json["locations"],
      cities: json["cities"],
      count: json["count"],
    );
  }

  static Resource<List<Country>> get all {
    return Resource(
        url: Constants.Countries_API,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result['results'];
          print("HELLO");
          print("result: ${result['results']}");
          return list.map((model) => Country.fromJson(model)).toList();
        });
  }
}

//////////////////
class Constants {
  static final String Countries_API =
      'https://api.openaq.org/v1/countries?limit=104';
}
