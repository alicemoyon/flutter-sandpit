import 'package:flutter/material.dart';
import 'package:fluttersandpit/utils/constants.dart';
import 'data/country.dart';
import 'navigation.dart';
import 'package:fluttersandpit/service/networkhelper.dart';

class AqScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CountryList());
  }
}

class CountryList extends StatefulWidget {
  @override
  createState() => CountryListState();
}

class CountryListState extends State<CountryList> {
  List<Country> _countries = List<Country>();
  static final nh = NetworkHelper(Constants.Countries_API);
  Future _loadData = nh.getData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _loadData,
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          //If error
          return Center(
            child: Text('${snapshot.error}'),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none: //If no data
            return Center(
              child: Text('No connection'),
            );
          case ConnectionState.waiting: //If waiting
            return Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done: //If finished
            _countries = [];
            for (var i = 0; i < snapshot.data['results'].length; i++) {
              _countries.add(Country.fromJson(snapshot.data['results'][i]));
            }
            return ListView.builder(
              itemCount: _countries.length,
              itemBuilder: _buildItemsForListView,
            );
        }
      },
    ));
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
        title: RaisedButton(
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
}
