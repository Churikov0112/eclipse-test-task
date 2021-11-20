import 'package:eclipse_test_task/models/comment/comment.dart';
import 'package:eclipse_test_task/models/post/post.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class PostsAndComments with ChangeNotifier {
  List<Post> _loadedPosts = [];

  List<Post> get posts {
    return _loadedPosts;
  }

  // загрузка списка постов из локальной БД или с сервера
  Future<void> fetchPosts() async {
    var postsData = await Hive.openBox<Post>('postsData');
    if (postsData.get(1) != null) {
      // если в БД есть посты
      print('Список постов был загружен из локальной БД');
      _loadedPosts.clear();
      for (var postData in postsData.values) {
        _loadedPosts.add(postData);
      }
    } else {
      // если в БД нет постов
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      final extractedData = json.decode(response.body);
      print('Список постов был загружен с сервера');
      _loadedPosts.clear();
      for (var post in extractedData) {
        Post newPost = Post(
          userId: post['userId'],
          id: post['id'],
          title: post['title'],
          body: post['body'],
          comments: [],
        );
        _loadedPosts.add(newPost);
        await postsData.put(newPost.id, newPost);
      }
      print('Список постов был добавлен в локальную БД');
    }
    notifyListeners();
  }

  // загрузка списка комментариев к посту из локальной БД или с сервера
  Future<void> fetchCommentsForPost(int postId) async {
    var postsData = await Hive.openBox<Post>('postsData');
    if (postsData.get(postId)!.comments.isNotEmpty) {
      // если в БД есть комменты к посту
      print('Список комментариев к посту был загружен из локальной БД');
      _loadedPosts.clear();
      for (var postData in postsData.values) {
        _loadedPosts.add(postData);
      }
    } else {
      // если в БД нет комментариев к посту
      final response = await http.get(
        Uri.parse(
            'https://jsonplaceholder.typicode.com/posts/${postId}/comments'),
      );
      final extractedData = json.decode(response.body);
      print('Список комментариев к посту был загружен с сервера');

      _loadedPosts.firstWhere((post) => post.id == postId).comments.clear();
      for (var comment in extractedData) {
        Comment newComment = Comment(
          postId: comment['postId'],
          id: comment['id'],
          name: comment['name'],
          body: comment['body'],
          email: comment['email'],
        );
        _loadedPosts
            .firstWhere((post) => post.id == comment['postId'])
            .comments
            .add(newComment);
      }
      //await postsData.delete(postId);
      postsData.put(
          postId, _loadedPosts.firstWhere((post) => post.id == postId));
      // await postsData.put(
      //   postId,
      //   _loadedPosts.firstWhere((post) => post.id == postId),
      // );
      print('Список комментариев к посту был добавлен в локальную БД');
    }
    notifyListeners();
  }

  // добавление комментария к посту (отправка на сервер + бд)
  Future<void> addCommentAndSendToServer({
    required int postId,
    required String title,
    required String body,
    required String email,
  }) async {
    Comment newComment;
    newComment = Comment(
      postId: postId,
      id: _loadedPosts.firstWhere((post) => post.id == postId).comments.length,
      name: title,
      body: body,
      email: email,
    );
    _loadedPosts
        .firstWhere((post) => post.id == postId)
        .comments
        .add(newComment);

    // ignore: unused_local_variable
    final response = await http.post(
      Uri.parse(
          'https://jsonplaceholder.typicode.com/posts/${postId}/comments/'),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: json.encode(
        {
          "postId": newComment.postId,
          "id": newComment.id,
          "name": newComment.name,
          "body": newComment.body,
          "email": newComment.email,
        },
      ),
    );
    //final extractedData = json.decode(response.body);
    print(
        'Комментарий был добавлен в БД на сервере (не по-настоящему, особенности сервиса)');
    var postsData = await Hive.openBox<Post>('postsData');
    postsData.put(postId, _loadedPosts.firstWhere((post) => post.id == postId));
    print('Комментарий был добавлен в локальную БД');
    notifyListeners();
  }
}
