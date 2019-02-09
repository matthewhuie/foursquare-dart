# Foursquare for Dart 
This is a Dart package for Foursquare that helps with accessing Foursquare API endpoints and Foursquare-related objects. Both userless and authenticated access is supported.

## Getting Started
Add this git as a dependency in `pubspec.yaml` of your Flutter project.
```yaml
dependencies:
  foursquare:
    git: git://github.com/matthewhuie/foursquare-dart.git
```

Import the package into your project.
```dart
import 'package:foursquare/foursquare.dart';

...

void main() async {
  API userless = await API.userless(
    'FOURSQUARE_CLIENT_ID', 
    'FOURSQUARE_CLIENT_SECRET');
  API authed = await API.authed('OAUTH_ACCESS_TOKEN');

  Venue current = await Venue.current(authed, 40, -74);
  print(current.name);
  
  ...

}
```

## TODO
- [x] Constructors for userless and authenticated access
- [x] Basic GET implementation
- [x] Basic objects - User, Venue
- [x] Basic API endpoints - user/X, venues/search
- [ ] Deeper object implementation
- [ ] Deeper API endpoint implementation
- [ ] dartdoc documentation

## Links
- https://enterprise.foursquare.com/products/places
- https://developer.foursquare.com/places-api
- https://dartlang.org
