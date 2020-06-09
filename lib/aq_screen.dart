import 'package:flutter/material.dart';
import 'package:fluttersandpit/service/web_service.dart';

import 'data/country.dart';
import 'navigation.dart';

class AqScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CountryList());
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

class CountryList extends StatefulWidget {
  @override
  createState() => CountryListState();
}

class CountryListState extends State<CountryList> {
  // static vars

  // instance vars
  //  public
  //  private

  List<Country> _countries = List<Country>();

  Future _loadData = NetworkHelper(url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _loadData,
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.error)
          return Center(
            child: Text('${snapshot.error}'),
          );
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: Text('No connection'),
            );
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            _countries = snapshot.data;

            return ListView.builder(
              itemCount: _countries.length,
              itemBuilder: _buildItemsForListView,
            );
        }
      },
    ));
  }

//  void _populateCountries() {
//    Webservice().load(Country.all).then((countries) => {
//          setState(() => {_countries = countries})
//        });
//  }

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
          MaterialPageRoute(
              builder: (context) => SecondRoute(
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
}
