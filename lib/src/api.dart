import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  final _apiAuthority = 'api.foursquare.com';
  final _apiVersion = { 'v': '20220901' };

  API.userless(String clientId, String clientSecret) {
    _authParameter = { 'client_id': clientId, 'client_secret': clientSecret };
    _isAuthed = false;
  }
  API.authed(String accessToken) {
    _authParameter = { 'oauth_token': accessToken };
    _isAuthed = true;
  }

  Map<String, String> _authParameter;
  bool _isAuthed;

  /// Performs a GET request to Foursquare API.
  Future<Map<String, dynamic>> get(String endpoint, {Map<String, String> parameters = const {}}) async {
    final url = Uri.https(_apiAuthority, 'v2/$endpoint', {..._apiVersion, ..._authParameter, ...parameters});
    final response = await http.get(url).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      return json.decode(response.body)['response'];
    } else {
      return null;
    }
  }

  // Performs a POST request to Foursquare API.
  Future<Map<String, dynamic>> post(String endpoint, {Map<String, String> parameters = const {}}) async {
    if (_isAuthed) {
      final url = Uri.https(_apiAuthority, 'v2/$endpoint', {..._apiVersion, ..._authParameter});
      final response = await http.post(url, body: parameters).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return json.decode(response.body)['response'];
      }
    }
    return null;
  }
}
