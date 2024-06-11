import 'package:flutter/material.dart';
import '../model/post.dart';
import '../repository/postRepository.dart';

class PostListModel with ChangeNotifier {
  late final PostRepository _postRepository;
  
  List<Post> _postList = List.empty(growable: true);
  List<Post> get postList => _postList;


  PostListModel() {
    _postRepository = PostRepository();
    _getPostList();
  }

  Future<void> _getPostList() async {
    _postList = await _postRepository.getPostList();
    notifyListeners();
  }

  Future<Post> createPost(code, comment, userId) async {
    final post = await _postRepository.createPost(code, comment, userId);
    return post;
  }

}