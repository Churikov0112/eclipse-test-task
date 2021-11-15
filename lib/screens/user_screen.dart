import 'package:eclipse_test_task/models/post/post.dart';
import 'package:eclipse_test_task/providers/posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eclipse_test_task/consts/my_colors.dart';
import 'package:eclipse_test_task/models/user/user.dart';
import 'package:eclipse_test_task/providers/users.dart';
import 'package:eclipse_test_task/widgets/my_appbar.dart';

class UserScreen extends StatefulWidget {
  final int id;

  static const routeName = '/user';

  UserScreen({
    required this.id,
  });

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isLoading = false;

  // метод для загрузки списка постов для данного пользователя
  void loadPosts() {
    setState(() {
      isLoading = true;
    });
    Provider.of<Posts>(context, listen: false).fetchPostsFromServer().then(
          (_) => setState(() {
            isLoading = false;
          }),
        );
  }

  @override
  initState() {
    loadPosts();
    super.initState();
  }

  // провью поста пользователя
  Widget postPreview({
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<Users>(context)
        .users
        .firstWhere((usr) => usr.id == widget.id);

    List<Post> userPosts = [];
    if (Provider.of<Posts>(context).posts.isNotEmpty) {
      for (var post in Provider.of<Posts>(context).posts) {
        if (post.userId == user.id) {
          userPosts.add(post);
        }
      }
    }

    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.light_white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 27),
              MyAppbar(
                deviceSize: deviceSize,
                title: '${user.username}',
                hasBackButton: true,
              ),
              SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(15),
                  width: deviceSize.width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Email : ' + user.email),
                      SizedBox(height: 20),
                      Text('Phone : ' + user.phone),
                      SizedBox(height: 20),
                      Text('Website : ' + user.website),
                      SizedBox(height: 20),
                      Text('Working : ' + user.company.name),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              Row(
                children: [
                  const SizedBox(width: 15),
                  Container(
                    width: (deviceSize.width - 60) / 3,
                    height: (deviceSize.width - 60) / 3,
                    color: Colors.red,
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: (deviceSize.width - 60) / 3,
                    height: (deviceSize.width - 60) / 3,
                    color: Colors.green,
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: (deviceSize.width - 60) / 3,
                    height: (deviceSize.width - 60) / 3,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 15),
                ],
              ),

              // список превью постов
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        postPreview(
                          title: isLoading ? "" : userPosts.last.title,
                          description: isLoading ? "" : userPosts.last.body,
                        ),
                        SizedBox(height: 10),
                        postPreview(
                          title: isLoading
                              ? ""
                              : userPosts[userPosts.length - 2].title,
                          description: isLoading
                              ? ""
                              : userPosts[userPosts.length - 2].body,
                        ),
                        SizedBox(height: 10),
                        postPreview(
                          title: isLoading
                              ? ""
                              : userPosts[userPosts.length - 3].title,
                          description: isLoading
                              ? ""
                              : userPosts[userPosts.length - 3].body,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
