import 'package:flutter/material.dart';
import 'package:fluttersandpit/countries_model.dart';
import 'package:fluttersandpit/networking.dart';
import 'package:provider/provider.dart';

const apiKey = 'cd83fb5dfa20b2cbed7125ed4992d7a9';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class Weather {
  int temperature;
  String description;

  Weather(this.temperature, this.description);
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Last Tapped"),
    content: Consumer<CountriesModel>(
      builder: (context, country, _) => Text(
          "The last country tapped was: ${country.lastTappedCountry.name ?? country.lastTappedCountry.code}"),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // Fetch the data from the OpenWeather API for a particular city
  static Future<Weather> getWeatherData(String cityName) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';

    NetworkHelper nh = NetworkHelper(url);

    var weatherData = await nh.getData();
    print(weatherData);
    double temp = weatherData['main']['temp'];
    int temperature = temp.toInt();
    String description = weatherData['weather'][0]['description'];
    Weather weatherInfo = Weather(temperature, description);
    return weatherInfo;
  }

  Future<Weather> weatherInfo = getWeatherData('Dublin');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Text("Better check if it's ice cream weather!"),
          //TextField(),
          RaisedButton(
            onPressed: () {},
            textColor: Colors.white,
            child: Text("Check Weather"),
            color: Colors.teal,
          ),
          FutureBuilder<Weather>(
            future: weatherInfo,
            //initialData: "initial data",
            //ignore: missing_return,
            builder: (BuildContext context, AsyncSnapshot<Weather> snapshot) {
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
                  return Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                          snapshot.data.description,
                        ),
                      ),
                      Center(
                        child: Text(
                          '${snapshot.data.temperature}',
                        ),
                      )
                    ],
                  );
              }
            },
          ),
          Consumer<CountriesModel>(
            builder: (context, country, _) {
              // Only show button if a country has been tapped
              if (country.lastTappedCountry != null)
                return FlatButton(
                  child: Text(
                    "check last tapped country",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    showAlertDialog(context);
                  },
                );
              else return Container(width: 0.0, height: 0.0);
            },),
        ],
      ),
    );
  }
}