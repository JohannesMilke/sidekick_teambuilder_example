import 'package:meta/meta.dart';

class User {
  final String name;
  final String imageUrl;
  bool isFavourite;

  User({
    @required this.name,
    @required this.imageUrl,
    this.isFavourite = false,
  });
}
