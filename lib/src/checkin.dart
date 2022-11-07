import 'api.dart';
import 'venue.dart';

class Checkin {
  Checkin({this.checkinId, this.type, this.createdAt, this.private, this.shout, this.venueId});

  final String? checkinId;
  final String? type;
  final int? createdAt;
  final bool? private;
  final String? shout;
  final String? venueId;

  factory Checkin.fromJson(Map<String, dynamic> json) {
    return Checkin(
      checkinId: json['id'],
      type: json['type'],
      createdAt: json['createdAt'],
      private: json['private'],
      shout: json['shout'] ?? null,
      venueId: json['venue']['id'] ?? null
    );
  }

  static Future<Checkin> add(API api, Venue venue, {bool private = false, double? latitude, double? longitude, String? shout}) async {
    Map<String, String> parameters = {};
    parameters['venueId'] = venue.venueId!;
    if (private) parameters['broadcast'] = 'private';
    if (latitude != null && longitude != null) parameters['ll'] = '${latitude.toString()},${longitude.toString()}';
    if (shout != null) parameters['shout'] = shout;

    return Checkin.fromJson((await api.post('checkins/add', parameters: parameters))!['checkin']);
  }
}
