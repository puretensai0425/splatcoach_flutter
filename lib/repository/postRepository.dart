import 'package:splatcoach/model/review.dart';

import '../dataSource/dataSource.dart';
import '../model/post.dart';

class PostRepository {
  final DataSource _dataSource = DataSource();

  Future<List<Post>> getPostList() {
    return _dataSource.getPostList();
  }

  Future<dynamic> getPostDetail(id) {
    return _dataSource.getPostDetail(id);
  }

  Future<Post> createPost(code, comment, userId) {
    return _dataSource.createPost(code, comment, userId);
  }

  Future<Review> createReview(point, comment, userId, postId) {
    return _dataSource.createReview(point, comment, userId, postId);
  }

}