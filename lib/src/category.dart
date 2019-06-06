import 'api.dart';

class Category {
  Category({this.categoryId, this.name});

  final String categoryId;
  final String name;

  factory Category.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return Category(
        categoryId: json['id'],
        name: json['name']
      );
    } else {
      return null;
    }
  }
}
