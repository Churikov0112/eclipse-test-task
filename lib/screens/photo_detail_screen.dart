import 'package:eclipse_test_task/models/photo/photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:dismissible_page/dismissible_page.dart';

// ignore: must_be_immutable
class PhotoDetailsScreen extends StatefulWidget {
  PhotoDetailsScreen({
    required this.photos,
    required this.initialPage,
  });

  List<Photo> photos = [];
  int initialPage;

  @override
  _PhotoDetailsScreenState createState() =>
      _PhotoDetailsScreenState(currentPageIndex: initialPage);
}

class _PhotoDetailsScreenState extends State<PhotoDetailsScreen> {
  _PhotoDetailsScreenState({required this.currentPageIndex});

  int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DismissiblePage(
        onDismiss: () => Navigator.of(context).pop(),
        isFullScreen: false,
        dragSensitivity: .4,
        maxTransformValue: 4,
        direction: DismissDirection.vertical,
        child: Material(
          color: Colors.transparent,
          child: Hero(
            tag: widget.initialPage,
            child: Stack(
              children: [
                // photo
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: ImageSlideshow(
                    /// Width of the [ImageSlideshow].
                    width: double.infinity,

                    /// Height of the [ImageSlideshow].
                    height: double.infinity,

                    /// The page to show when first creating the [ImageSlideshow].
                    initialPage: widget.initialPage,

                    /// The color to paint the indicator.
                    indicatorColor: Colors.transparent,

                    /// The color to paint behind th indicator.
                    indicatorBackgroundColor: Colors.transparent,

                    /// The widgets to display in the [ImageSlideshow].
                    /// Add the sample image file into the images folder
                    children: [
                      for (var photo in widget.photos) Image.network(photo.url),
                    ],

                    /// Called whenever the page in the center of the viewport changes.
                    onPageChanged: (value) {
                      setState(() {
                        currentPageIndex = value;
                      });
                      print(currentPageIndex);
                    },
                  ),
                ),

                // description
                Positioned(
                  bottom: 50,
                  left: 30,
                  right: 30,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    child: Text(
                      widget.photos[currentPageIndex].title,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
