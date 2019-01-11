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

Future<void> initFoursquare() async {
  API userless = await API.userless(
    'FOURSQUARE_CLIENT_ID', 
    'FOURSQUARE_CLIENT_SECRET');
  API authed = await API.authed('OAUTH_ACCESS_TOKEN');

  List<Venue> results = await userless.venueSearch(latitude: 40, longitude: -74);

  ...

}
```

## TODO
- [x] Constructors for userless and authenticated access
- [x] Basic GET implementation
- [x] Basic objects - User, Venue
- [x] Basic API endpoints - userDetails, venueSearch
- [ ] Deeper object implementation
- [ ] Deeper API endpoint implementation
- [ ] dartdoc documentation

## Links
- https://enterprise.foursquare.com/products/places
- https://developer.foursquare.com/places-api
- https://dartlang.org
