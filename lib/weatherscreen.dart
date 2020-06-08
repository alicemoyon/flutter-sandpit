import 'package:flutter/material.dart';
import 'package:fluttersandpit/networking.dart';

const apiKey = 'cd83fb5dfa20b2cbed7125ed4992d7a9';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class Weather {
  int temperature;
  String description;

  Weather(this.temperature, this.description);
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
        ],
      ),
    );
  }
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
