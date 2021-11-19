import 'package:hive/hive.dart';
part 'photo.g.dart';

@HiveType(typeId: 5)
class Photo extends HiveObject {
  @HiveField(0)
  int albumId;

  @HiveField(1)
  int id;

  @HiveField(2)
  String title;

  @HiveField(3)
  String url;

  @HiveField(4)
  String humbnailUrl;

  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.humbnailUrl,
  });
}
