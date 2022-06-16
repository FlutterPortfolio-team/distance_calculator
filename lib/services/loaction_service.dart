import 'package:distance_calculator/services/networking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'auth/secret.dart';
class LocationService {

 
 Future<String> getPlaceId(String input) async {
  final String url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textqquery&key=$myKey';
   var response = await http.get(Uri.parse(url));
   var json = convert.jsonDecode(response.body);
   var placeId = json['candidate'][0]['place_id'] as String;
   print('this is location response $json');
   print('this is location id $placeId');
   return placeId;
 
  }

  Future<Map<String, dynamic>> getPlace(String input)async {
    final placeId = getPlaceId(input);

    final String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$myKey';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    print(results);
    return results;

  }

}