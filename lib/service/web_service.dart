import 'dart:convert';

import 'package:fluttersandpit/data/country.dart';
import 'package:fluttersandpit/utils/constants.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

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
    } else {
      throw Exception('Failed to load data!');
    }
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
