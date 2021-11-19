// ignore_for_file: must_be_immutable

import 'package:eclipse_test_task/consts/my_colors.dart';
import 'package:eclipse_test_task/providers/albums_and_photos.dart';
import 'package:eclipse_test_task/screens/photo_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlbumDetailsScreen extends StatelessWidget {
  AlbumDetailsScreen({
    required this.albumId,
  });

  int albumId;

  @override
  Widget build(BuildContext context) {
    var album = Provider.of<AlbumsAndPhotos>(context)
        .albums
        .firstWhere((albm) => albm.id == albumId);

    print(album.photos.length);

    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
        backgroundColor: MyColors.light_white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2.5,
            mainAxisSpacing: 2.5,
            childAspectRatio: 1,
          ),
          itemCount: album.photos.length,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => PhotoDetailsScreen(
                      photos: album.photos,
                      initialPage: index,
                    ),
                  ),
                );
              },
              child: Hero(
                tag: index,
                child: Container(
                  width: (deviceSize.width - 60) / 3,
                  child: Column(
                    children: [
                      ClipRRect(
                        child: Image.network(
                          album.photos[index].humbnailUrl,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
