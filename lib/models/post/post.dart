import 'package:eclipse_test_task/models/comment/comment.dart';

class Post {
  int userId;
  int id;
  String title;
  String body;
  List<Comment> comments;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    required this.comments,
  });
}
