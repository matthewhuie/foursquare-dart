import 'api.dart';
import 'checkin.dart';

class User {
  User({this.userId, this.firstName, this.lastName, this.photoPrefix, this.photoSuffix, this.homeCity});

  final String userId;
  final String firstName;
  final String lastName;
  final String photoPrefix;
  final String photoSuffix;
  final String homeCity;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      photoPrefix: json['photo']['prefix'],
      photoSuffix: json['photo']['suffix'],
      homeCity: json['homeCity'] ?? ''
    );
  }

  static Future<User> get(API api, {userId = 'self'}) async {
    return User.fromJson((await api.get('users/$userId'))['user']);
  }

  static Future<List<User>> friends(API api, {userId = 'self'}) async {
    List items = (await api.get('users/$userId/friends', '&limit=10000'))['friends']['items'];
    return items.map((item) => User.fromJson(item)).toList();
  }

  static Future<List<Checkin>> checkins(API api, {userId = 'self'}) async {
    List items = (await api.get('users/$userId/checkins', '&limit=250'))['checkins']['items'];
    return items.map((item) => Checkin.fromJson(item)).toList();
  }
}
