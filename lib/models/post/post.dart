import 'package:eclipse_test_task/models/comment/comment.dart';
import 'package:hive/hive.dart';
part 'post.g.dart';

@HiveType(typeId: 3)
class Post extends HiveObject {
  @HiveField(0)
  int userId;

  @HiveField(1)
  int id;

  @HiveField(2)
  String title;

  @HiveField(3)
  String body;

  @HiveField(4)
  List<Comment> comments;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    required this.comments,
  });
}
