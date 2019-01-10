class Venue {
  Venue({this.venueId, this.name, this.location, this.category, this.rating});

  final String venueId;
  final String name;
  final String location;
  final String category;
  final double rating;

  @override
  String toString() {
    return '$venueId, $name, $location, $category, $rating';
  }

  bool operator ==(otherVenue) => otherVenue is Venue && venueId == otherVenue.venueId;
  int get hashCode => venueId.hashCode;

  factory Venue.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return Venue(
          venueId: json['id'],
          name: json['name'],
          location: '${json['location']['city']}, ${json['location']['state']}, ${json['location']['cc']}' ?? '',
          category: json['categories'][0]['name'] ?? '',
          rating: json['rating']
      );
    } else {
      return null;
    }
  }
}
