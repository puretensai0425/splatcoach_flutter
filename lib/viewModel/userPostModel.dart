import 'package:flutter/material.dart';
import '../repository/userRepository.dart';
import '../model/post.dart';

class UserPostModel with ChangeNotifier {
  late final UserRepository _userRepository;

  List<Post> _userPost = List.empty(growable: true);
  List<Post> get userPost => _userPost;

  UserPostModel(id) {
    _userRepository = UserRepository();
    _getUserPost(id);
  }

  Future<void> _getUserPost(id) async {
    _userPost = await _userRepository.getUserPostList(id);
    notifyListeners();
  }
}