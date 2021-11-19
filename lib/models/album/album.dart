import 'package:eclipse_test_task/models/photo/photo.dart';

class Album {
  int userId;
  int id;
  String title;
  List<Photo> photos;

  Album({
    required this.userId,
    required this.id,
    required this.title,
    required this.photos,
  });
}
