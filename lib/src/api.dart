import 'dart:convert';
import 'package:http/http.dart' as http;
import 'venue.dart';

class API {
  API.userless(String clientId, String clientSecret) {
    _authParameter = '&client_id=$clientId&client_secret=$clientSecret'
  }
  API.authed(String accessToken) {
    _authParameter = '&oauth_token=$authToken'
  }

  String _authParameter;

  Future<Map<String, dynamic>> get (String endpoint, [String parameters='']) async {
    final response = await http
      .get('https://api.foursquare.com/v2/$endpoint?v=20190101$_authParameter$parameters')
      .timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      return json.decode(response.body)['response'];
    } else {
      return null;
    }
  }

  Set<Venue> getLikedVenues (String userId) {
    List items = get('lists/$userId/venuelikes', 'limit=10000')['list']['listItems']['items'];
    return items
      .where((item) => item['type'] == 'venue')
      .map((item) => Venue.fromJson(item['venue'])).toSet();
  }
}
