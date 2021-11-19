import 'package:hive/hive.dart';
part 'comment.g.dart';

@HiveType(typeId: 6)
class Comment extends HiveObject {
  @HiveField(0)
  int postId;

  @HiveField(1)
  int id;

  @HiveField(2)
  String name;

  @HiveField(3)
  String body;

  @HiveField(4)
  String email;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.body,
    required this.email,
  });
}
