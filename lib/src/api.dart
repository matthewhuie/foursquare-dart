import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'venue.dart';

class API {
  API.userless(String clientId, String clientSecret) {
    _authParameter = '&client_id=$clientId&client_secret=$clientSecret'
    _isAuthed = false;
  }
  API.authed(String accessToken) {
    _authParameter = '&oauth_token=$authToken'
    _isAuthed = true;
  }

  String _authParameter;
  bool _isAuthed;

  /// Performs a GET request to Foursquare
  Future<Map<String, dynamic>> get(String endpoint, [String parameters='']) async {
    final response = await http
      .get('https://api.foursquare.com/v2/$endpoint?v=20190101$_authParameter$parameters')
      .timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      return json.decode(response.body)['response'];
    } else {
      return null;
    }
  }

  List<Venue> venueSearch(double latitude, double longitude, [String parameters='']) {
    List items = get('venues/search', '&ll=$latitude,$longitude$parameters')['venues']
    return items.map((item) => Venue.fromJson(item)).toList();
  }

  List<Venue> venuesLiked(String userId) {
    List items = get('lists/$userId/venuelikes', '&limit=10000')['list']['listItems']['items'];
    return items
      .where((item) => item['type'] == 'venue')
      .map((item) => Venue.fromJson(item['venue'])).toList();
  }

  List<Venue> venuesSaved(String userId) {
    List items = get('lists/$userId/todos', '&limit=10000')['list']['listItems']['items'];
    return items
      .where((item) => item['type'] == 'venue')
      .map((item) => Venue.fromJson(item['venue'])).toList();
  }

  User userDetails(String userId) {
    return User.fromJson(get('users/$userId')['user']);
  }
}
