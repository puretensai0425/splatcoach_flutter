import 'package:flutter/material.dart';
import '../repository/userRepository.dart';
import '../model/review.dart';

class UserReviewModel with ChangeNotifier {
  late final UserRepository _userRepository;

  List<Review> _userReview = List.empty(growable: true);
  List<Review> get userReview => _userReview;

  UserReviewModel(id) {
    _userRepository = UserRepository();
    _getUserReview(id);
  }

  Future<void> _getUserReview(id) async {
    _userReview = await _userRepository.getUserReviewList(id);
    notifyListeners();
  }
}