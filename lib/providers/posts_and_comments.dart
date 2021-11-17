import 'package:eclipse_test_task/models/comment/comment.dart';
import 'package:eclipse_test_task/models/post/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class PostsAndComments with ChangeNotifier {
  List<Post> _loadedPosts = [];

  List<Post> get posts {
    return _loadedPosts;
  }

  Future<void> fetchPostsFromServer() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    final extractedData = json.decode(response.body);
    //print(extractedData);
    _loadedPosts.clear();
    for (var post in extractedData) {
      _loadedPosts.add(
        Post(
          userId: post['userId'],
          id: post['id'],
          title: post['title'],
          body: post['body'],
          comments: [],
        ),
      );
    }
    notifyListeners();
  }

  Future<void> fetchCommentsForPostFromServer(int postId) async {
    final response = await http.get(
      Uri.parse(
          'https://jsonplaceholder.typicode.com/posts/${postId}/comments'),
    );
    final extractedData = json.decode(response.body);
    print(extractedData);
    _loadedPosts.firstWhere((post) => post.id == postId).comments.clear();
    for (var comment in extractedData) {
      _loadedPosts
          .firstWhere((post) => post.id == comment['postId'])
          .comments
          .add(
            Comment(
              postId: comment['postId'],
              id: comment['id'],
              name: comment['name'],
              body: comment['body'],
              email: comment['email'],
            ),
          );
    }
    notifyListeners();
  }

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
    final extractedData = json.decode(response.body);
    print(extractedData);
    notifyListeners();
  }
}
