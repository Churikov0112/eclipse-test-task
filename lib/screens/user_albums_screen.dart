import 'package:eclipse_test_task/consts/my_colors.dart';
import 'package:eclipse_test_task/models/album/album.dart';
import 'package:eclipse_test_task/providers/albums_and_photos.dart';
import 'package:eclipse_test_task/providers/users.dart';
import 'package:eclipse_test_task/screens/album_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserAlbumsScreen extends StatelessWidget {
  UserAlbumsScreen({
    required this.userId,
  });

  int userId;

  @override
  Widget build(BuildContext context) {
    List<Album> userAlbums = [];
    for (var album in Provider.of<AlbumsAndPhotos>(context).albums) {
      if (album.userId == userId) {
        userAlbums.add(album);
      }
    }

    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${Provider.of<Users>(context, listen: false).users.firstWhere((user) => user.id == userId).username}\'s albums'),
        backgroundColor: MyColors.light_white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 4 / 5,
        ),
        padding: EdgeInsets.all(10),
        itemCount: userAlbums.length,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      AlbumDetailsScreen(albumId: userAlbums[index].id),
                ),
              );
            },
            child: Container(
              width: (deviceSize.width - 60) / 3,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      userAlbums[index].photos.last.url,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    userAlbums[index].title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
