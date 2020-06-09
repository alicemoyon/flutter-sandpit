import 'package:flutter/material.dart';
import 'package:fluttersandpit/countries_model.dart';
import 'package:fluttersandpit/country_info_screen.dart';
import 'package:provider/provider.dart';
import 'country.dart';
import 'networking.dart';

var url = 'https://api.openaq.org/v1/countries?limit=100';

class AqScreen extends StatefulWidget {
  static Future<List<Country>> getCountries() async {
    NetworkHelper nh = NetworkHelper(url);
    var countryData = await nh.getData();
    List<dynamic> countryInfo = countryData['results'];

    List<Country> countries = [];
    countryInfo.forEach((element) {
      countries.add(
        Country(
          element['code'],
          element['count'],
          element['locations'],
          element['cities'],
          element['name'],
        ),
      );
    });

    return countries;
  }

  @override
  _AqScreenState createState() => _AqScreenState();
}

class _AqScreenState extends State<AqScreen> {

  final Future<List> countries = AqScreen.getCountries();

  //String lastTappedCountry;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: countries,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
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
                        child: Text("fetching the countries"),
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
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.data[index].name != null) {
                      return ListTile(
                        title: Text(snapshot.data[index].name),
                        trailing: FlatButton(
                          child: Icon(snapshot.data[index].getFave() ? Icons.favorite : Icons.favorite_border, color: Colors.red,),
                          onPressed: () {
                            setState(() {
                              snapshot.data[index].toggleFave();
                            });
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CountryInfoScreen(snapshot.data[index]),
                            ),
                          );
                          Provider.of<CountriesModel>(context, listen: false).tapCountry(snapshot.data[index]);
                        },
                      );
                    } else {
                      return ListTile(
                        title: Text(snapshot.data[index].code),
                        trailing: FlatButton(
                          child: Icon(snapshot.data[index].getFave() ? Icons.favorite : Icons.favorite_border, color: Colors.red,),
                          onPressed: () {
                            setState(() {
                              snapshot.data[index].toggleFave();
                            });
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CountryInfoScreen(snapshot.data[index]),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              default:
                return Text(
                  "something else happened",
                );
            }
          }),
    );
  }
}
