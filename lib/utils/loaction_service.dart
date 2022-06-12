import 'package:distance_calculator/utils/networking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class LocationService {

  final String key = 'AIzaSyDlgfx0wvpJt2RHAKkMivPx0IGXP38JVSY';
 
 Future<String> getPlaceId(String input) async {
  final String url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textqquery&key=$key';
   var response = await http.get(Uri.parse(url));
   var json = convert.jsonDecode(response.body);
   var placeId = json['candidate'][0]['place_id'] as String;
   print('this is location response $json');
   print('this is location id $placeId');
   return placeId;
 
  }

}