import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  final _apiVersion = '20220901';

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
      .get('https://api.foursquare.com/v2/$endpoint?v=$_apiVersion$_authParameter$parameters')
      .timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      return json.decode(response.body)['response'];
    } else {
      return null;
    }
  }

  // Performs a POST request to Foursquare API.
  Future<Map<String, dynamic>> post(String endpoint, [String parameters='']) async {
    if (_isAuthed) {
      final response = await http
        .post(
          'https://api.foursquare.com/v2/$endpoint?v=$_apiVersion$_authParameter',
          body: parameters
        ).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return json.decode(response.body)['response'];
      }
    }
    return null;
  }
}
