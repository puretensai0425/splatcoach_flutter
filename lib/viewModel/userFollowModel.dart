import 'package:flutter/material.dart';
import 'package:splatcoach/model/user.dart';
import '../repository/userRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserFollowModel with ChangeNotifier {
  late final UserRepository _userRepository;

  dynamic _userFollows;
  dynamic get userFollows => _userFollows;

  dynamic follows;

  UserFollowModel(id) {
    _userRepository = UserRepository();
    _getUserFollows(id);
  }

  Future<void> _getUserFollows(id) async {
    _userFollows = await _userRepository.getFollows(id);
    print("_getUserFollows async");

    for (User _userFollow in _userFollows['followers']) {
      print(_userFollow.following);
    }
    notifyListeners();
  }

  Future<void> createFollow(userId, followerId) async {
    final prefs = await SharedPreferences.getInstance();
    final loginId = int.parse(prefs.getString('login_user_id') as String);

    dynamic _userFollow = await _userRepository.createFollow(loginId, followerId);
    _getUserFollows(userId);
    notifyListeners();
  }
}