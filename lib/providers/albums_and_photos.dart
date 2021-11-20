import 'package:eclipse_test_task/models/album/album.dart';
import 'package:eclipse_test_task/models/photo/photo.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class AlbumsAndPhotos with ChangeNotifier {
  List<Album> _loadedAlbums = [];

  List<Album> get albums {
    return _loadedAlbums;
  }

  // метод для загрузки всех альбомов и url фото в каждом + сохранение в бд
  Future<void> fetchAlbumsWithPhotos() async {
    var albumsData = await Hive.openBox<Album>('albumsData');
    if (albumsData.get(1) != null) {
      // если в БД есть альбомы
      print('Список альбомов и список url фото были загружены из локальной БД');
      _loadedAlbums.clear();
      for (var albumData in albumsData.values) {
        _loadedAlbums.add(albumData);
      }
    } else {
      // если в БД нет альбомов
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

      print('Список альбомов и список url фото были загружены с сервера');
      _loadedAlbums.clear();

      // добавление альбомов (без фото)
      for (var album in extractedAblumsData) {
        Album newAlbum = Album(
          userId: album['userId'],
          id: album['id'],
          title: album['title'],
          photos: [],
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
          if (newPhoto.albumId == newAlbum.id) {
            newAlbum.photos.add(newPhoto);
          }
        }

        _loadedAlbums.add(newAlbum);
        albumsData.put(newAlbum.id, newAlbum);
      }
      print('Список альбомов и список url фото был добавлен в локальную БД');
    }
    notifyListeners();
  }
}
