import 'package:flutter/material.dart';
import 'package:splatcoach/model/user.dart';
import '../repository/userRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserShowModel with ChangeNotifier {
  late final UserRepository _userRepository;

  User _userDetail = User();
  User get userDetail => _userDetail;

  UserShowModel(id) {
    _userRepository = UserRepository();
    _getUserDetail(id);
  }

  Future<void> _getUserDetail(id) async {
    _userDetail = await _userRepository.getUser(id);
    print("_getUserDetail async");
    print(_userDetail.name);
    
    notifyListeners();
  }

  Future<void> createFollow(userId) async {
    final prefs = await SharedPreferences.getInstance();
    final loginId = int.parse(prefs.getString('login_user_id') as String);

    dynamic _userFollow = await _userRepository.createFollow(loginId, userId);
    _getUserDetail(userId);
    notifyListeners();
  }
}