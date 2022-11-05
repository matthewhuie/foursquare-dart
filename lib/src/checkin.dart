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
}
