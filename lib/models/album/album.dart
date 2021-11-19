import 'package:eclipse_test_task/models/photo/photo.dart';
import 'package:hive/hive.dart';
part 'album.g.dart';

@HiveType(typeId: 4)
class Album extends HiveObject {
  @HiveField(0)
  int userId;

  @HiveField(1)
  int id;

  @HiveField(2)
  String title;

  @HiveField(3)
  List<Photo> photos;

  Album({
    required this.userId,
    required this.id,
    required this.title,
    required this.photos,
  });
}
