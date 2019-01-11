import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'venue.dart';

class API {
  API.userless(String clientId, String clientSecret) {
    _authParameter = '&client_id=$clientId&client_secret=$clientSecret';
    _isAuthed = false;
  }
  API.authed(String accessToken) {
    _authParameter = '&oauth_token=$accessToken';
    _isAuthed = true;
  }

  String _authParameter;
  bool _isAuthed;

  /// Performs a GET request to Foursquare API.
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

  Future<List<Venue>> venueSearch(double latitude, double longitude, [String parameters='']) async {
    List items = (await get('venues/search', '&ll=$latitude,$longitude$parameters'))['venues'];
    return items.map((item) => Venue.fromJson(item)).toList();
  }

  Future<List<Venue>> venuesLiked(String userId) async {
    List items = (await get('lists/$userId/venuelikes', '&limit=10000'))['list']['listItems']['items'];
    return items
      .where((item) => item['type'] == 'venue')
      .map((item) => Venue.fromJson(item['venue'])).toList();
  }

  Future<List<Venue>> venuesSaved(String userId) async {
    List items = (await get('lists/$userId/todos', '&limit=10000'))['list']['listItems']['items'];
    return items
      .where((item) => item['type'] == 'venue')
      .map((item) => Venue.fromJson(item['venue'])).toList();
  }

  Future<User> userDetails(String userId) async {
    return User.fromJson((await get('users/$userId'))['user']);
  }
}
