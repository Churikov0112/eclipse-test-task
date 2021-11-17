import 'package:eclipse_test_task/models/album/album.dart';
import 'package:eclipse_test_task/models/photo/photo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class AlbumsAndPhotos with ChangeNotifier {
  List<Album> _loadedAlbums = [];

  List<Album> get albums {
    return _loadedAlbums;
  }

  // метод для загрузки альбомов и url фото в каждом
  Future<void> fetchAlbumsWithPhotosFromServer() async {
    // загрузка списка альбомов
    final responseAblums = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/'),
    );
    final extractedAblumsData = json.decode(responseAblums.body);

    // загрузка списка фото
    final responsePhotos = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos/'),
    );
    final extractedPhotosData = json.decode(responsePhotos.body);

    _loadedAlbums.clear();

    // добавление альбомов (без фото)
    for (var album in extractedAblumsData) {
      Album newAlbum = Album(
        userId: album['userId'],
        id: album['id'],
        title: album['title'],
        photoURIs: [],
      );

      // добавление фото в альбомы
      for (var photo in extractedPhotosData) {
        Photo newPhoto = Photo(
          albumId: photo['albumId'],
          id: photo['id'],
          title: photo['title'],
          url: photo['url'],
          humbnailUrl: photo['humbnailUrl'] ?? photo['url'],
        );
        newAlbum.photoURIs.add(newPhoto);
      }
      _loadedAlbums.add(newAlbum);
    }
    notifyListeners();
  }
}
