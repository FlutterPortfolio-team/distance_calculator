import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoding/geocoding.dart';

const String apiKey = '';

class Networking {
  Future getData(String origin, String destination) async {
    final String url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$destination&origins=$origin&units=imperial&key=$apiKey';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //   String distance = data['rows'][0]['elements'][0]['distance']['text'];
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
