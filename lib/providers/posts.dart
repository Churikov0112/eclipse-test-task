import 'package:eclipse_test_task/models/post/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Posts with ChangeNotifier {
  List<Post> _loadedPosts = [];

  List<Post> get posts {
    return _loadedPosts;
  }

  Future<void> fetchPostsFromServer() async {
    print('метод fetchPostsFromServer() начал свое выполнение');
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    final extractedData = json.decode(response.body);
    print(extractedData);
    _loadedPosts.clear();
    for (var post in extractedData) {
      _loadedPosts.add(
        Post(
          userId: post['userId'],
          id: post['id'],
          title: post['title'],
          body: post['body'],
        ),
      );
    }
    notifyListeners();
  }
}
