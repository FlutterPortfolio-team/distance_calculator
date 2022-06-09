import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoding/geocoding.dart';

const String apiKey = '';
late String destination;
late String origin;
const String url =
    'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$destination&origins=$origin&units=imperial&key=$apiKey';

class Networking {
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
