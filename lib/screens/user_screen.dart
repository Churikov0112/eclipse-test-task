import 'package:eclipse_test_task/models/album/album.dart';
import 'package:eclipse_test_task/models/post/post.dart';
import 'package:eclipse_test_task/providers/albums_and_photos.dart';
import 'package:eclipse_test_task/providers/posts_and_comments.dart';
import 'package:eclipse_test_task/screens/user_posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eclipse_test_task/consts/my_colors.dart';
import 'package:eclipse_test_task/models/user/user.dart';
import 'package:eclipse_test_task/providers/users.dart';

class UserScreen extends StatefulWidget {
  final int id;

  UserScreen({
    required this.id,
  });

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isLoading = false;

  // метод для загрузки превью и альбомов постов для данного пользователя
  void loadPostsAndAlbums() {
    setState(() {
      isLoading = true;
    });
    Provider.of<PostsAndComments>(context, listen: false)
        .fetchPostsFromServer()
        .then(
          (_) => Provider.of<AlbumsAndPhotos>(context, listen: false)
              .fetchAlbumsWithPhotosFromServer()
              .then(
                (_) => setState(
                  () {
                    isLoading = false;
                  },
                ),
              ),
        );
  }

  @override
  initState() {
    loadPostsAndAlbums();
    super.initState();
  }

  // карточка с информацией о пользователе
  Widget infoInfoCard(User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(15),
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
            SizedBox(height: 10),
            Row(
              children: [
                Text('Email : ' + user.email),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () => print('copy email'),
                  child: Text('Copy'),
                ),
              ],
            ),
            Row(
              children: [
                Text('Phone : ' + user.phone),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () => print('copy phone'),
                  child: Text('Copy'),
                ),
              ],
            ),
            Row(
              children: [
                Text('Website : ' + user.website),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () => print('copy website'),
                  child: Text('Copy'),
                ),
              ],
            ),
            Row(
              children: [
                Text('Working : ' + user.company.name),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () => print('copy working'),
                  child: Text('Copy'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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

  // провью альбома пользователя
  Widget albumPreview({
    required Album? album,
    required Size deviceSize,
  }) {
    return Container(
      width: (deviceSize.width - 60) / 3,
      child: Column(
        children: [
          isLoading
              ? Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    height: 45,
                    width: 45,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    album!.photoURIs.last.humbnailUrl,
                  ),
                ),
          SizedBox(height: 5),
          Text(
            isLoading ? "loading..." : " " + album!.title,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<Users>(context)
        .users
        .firstWhere((usr) => usr.id == widget.id);

    List<Post> userPosts = [];
    if (Provider.of<PostsAndComments>(context).posts.isNotEmpty) {
      for (var post in Provider.of<PostsAndComments>(context).posts) {
        if (post.userId == user.id) {
          userPosts.add(post);
        }
      }
    }

    List<Album> userAlbums = [];
    if (Provider.of<AlbumsAndPhotos>(context).albums.isNotEmpty) {
      for (var album in Provider.of<AlbumsAndPhotos>(context).albums) {
        if (album.userId == user.id) {
          userAlbums.add(album);
        }
      }
    }

    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.light_white,
      appBar: AppBar(
        title: Text('${user.username}'),
        backgroundColor: MyColors.light_white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              // карточка user info
              infoInfoCard(user),

              SizedBox(height: 10),

              Divider(),

              SizedBox(height: 10),

              // 3 превью альбомов
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // albums and show more
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Text(
                        'Albums',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Show more',
                        style: TextStyle(
                          color: MyColors.light_blue,
                        ),
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                  SizedBox(height: 10),

                  // 3 albums preview
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Row(
                          children: [
                            const SizedBox(width: 15),
                            albumPreview(
                              album: isLoading ? null : userAlbums[0],
                              deviceSize: deviceSize,
                            ),
                            SizedBox(width: 15),
                            albumPreview(
                              album: isLoading ? null : userAlbums[1],
                              deviceSize: deviceSize,
                            ),
                            SizedBox(width: 15),
                            albumPreview(
                              album: isLoading ? null : userAlbums[2],
                              deviceSize: deviceSize,
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                ],
              ),

              SizedBox(height: 10),

              Divider(),

              SizedBox(height: 20),

              // 3 превью постов
              Column(
                children: [
                  // albums and show more
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Text(
                        'Posts',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  UserPostsScreen(userId: widget.id),
                            ),
                          );
                        },
                        child: Text(
                          'Show more',
                          style: TextStyle(
                            color: MyColors.light_blue,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                  SizedBox(height: 10),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            postPreview(
                              title: isLoading ? "" : userPosts.last.title,
                              description: isLoading ? "" : userPosts.last.body,
                              deviceSize: deviceSize,
                            ),
                            SizedBox(height: 10),
                            postPreview(
                              title: isLoading
                                  ? ""
                                  : userPosts[userPosts.length - 2].title,
                              description: isLoading
                                  ? ""
                                  : userPosts[userPosts.length - 2].body,
                              deviceSize: deviceSize,
                            ),
                            SizedBox(height: 10),
                            postPreview(
                              title: isLoading
                                  ? ""
                                  : userPosts[userPosts.length - 3].title,
                              description: isLoading
                                  ? ""
                                  : userPosts[userPosts.length - 3].body,
                              deviceSize: deviceSize,
                            ),
                          ],
                        ),
                ],
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
