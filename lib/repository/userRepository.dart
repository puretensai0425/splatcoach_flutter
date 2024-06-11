import 'package:splatcoach/model/post.dart';
import 'package:splatcoach/model/review.dart';
import 'package:splatcoach/model/user.dart';

import '../dataSource/dataSource.dart';

class UserRepository {
  final DataSource _dataSource = DataSource();

  Future<dynamic> getFollows(id) {
    return _dataSource.getFollows(id);
  }

  Future<dynamic> createFollow(userId, followerId) {
    return _dataSource.createFollow(userId, followerId);
  }

  Future<User> getUser(id) {
    return _dataSource.getUser(id);
  }

  Future<List<Post>> getUserPostList(id) {
    return _dataSource.getUserPostList(id);
  }

  Future<List<Review>> getUserReviewList(id) {
    return _dataSource.getUserReviewList(id);
  }

  Future<User> profile(userId, name) {
    return _dataSource.profile(userId, name);
  }

  Future<User> register(email, displayName, photoUrl, g_id) {
    return _dataSource.register(email, displayName, photoUrl, g_id);
  }
}