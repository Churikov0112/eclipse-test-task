import 'package:eclipse_test_task/consts/my_colors.dart';
import 'package:eclipse_test_task/models/post/post.dart';
import 'package:eclipse_test_task/models/user/user.dart';
import 'package:eclipse_test_task/providers/posts_and_comments.dart';
import 'package:eclipse_test_task/providers/users.dart';
import 'package:eclipse_test_task/screens/post_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserPostsScreen extends StatelessWidget {
  UserPostsScreen({
    required this.userId,
  });

  int userId;

  // провью поста пользователя
  Widget postPreview({
    required String title,
    required String description,
    required Size deviceSize,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            width: deviceSize.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // заголовок
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                // 1 строчка текста
                Text(
                  description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User user =
        Provider.of<Users>(context).users.firstWhere((usr) => usr.id == userId);

    List<Post> userPosts = [];
    if (Provider.of<PostsAndComments>(context).posts.isNotEmpty) {
      for (var post in Provider.of<PostsAndComments>(context).posts) {
        if (post.userId == user.id) {
          userPosts.add(post);
        }
      }
    }

    Size deviceSize = MediaQuery.of(context).size;

    AppBar appBar = AppBar(
      title: Text('${user.username}\'s posts'),
      backgroundColor: MyColors.light_white,
      foregroundColor: Colors.black,
      elevation: 0.5,
    );

    return Scaffold(
      backgroundColor: MyColors.light_white,
      appBar: appBar,
      body: Container(
        height: deviceSize.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom -
            appBar.preferredSize.height,
        child: ListView.builder(
          itemCount: userPosts.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => PostDetailsScreen(
                    postId: userPosts[index].id,
                    user: user,
                  ),
                ),
              );
            },
            child: Column(
              children: [
                index == 0 ? SizedBox(height: 20) : SizedBox(),
                postPreview(
                  title: userPosts[index].title,
                  description: userPosts[index].body,
                  deviceSize: deviceSize,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
