import 'package:flutter/material.dart';
import 'package:spark/data/tweet.dart';

class PostsProvider extends ChangeNotifier {
  List<Tweet> _posts = [];

  List<Tweet> get posts => _posts;

  void addPost(Tweet post) {
    _posts.add(post);
    notifyListeners();
  }
}