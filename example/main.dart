import 'package:foursquare/foursquare.dart';

void main() async {
  // Used for userless requests
  API userless = await API.userless(
    'FOURSQUARE_CLIENT_ID', 
    'FOURSQUARE_CLIENT_SECRET');

  // Used for authenticated requests
  API authed = await API.authed('OAUTH_ACCESS_TOKEN');

  Venue current = await Venue.current(userless, 43.6532, -79.3832);
  print('I am at ${current.name}.');

  User self = await User.get(authed);
  print('I am ${self.firstName} ${self.lastName}.');
}
