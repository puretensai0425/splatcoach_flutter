import 'package:flutter/material.dart';
import '../repository/postRepository.dart';

class PostShowModel with ChangeNotifier {
  late final PostRepository _postRepository;

  dynamic _postDetail;
  dynamic get postDetail => _postDetail;

  PostShowModel(id) {
    _postRepository = PostRepository();
    _getPostDetail(id);
  }

  Future<void> _getPostDetail(id) async {
    _postDetail = await _postRepository.getPostDetail(id);
    notifyListeners();
  }
}