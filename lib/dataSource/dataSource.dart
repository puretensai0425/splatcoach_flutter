import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:splatcoach/model/review.dart';
import '../model/post.dart';
import '../model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataSource {
  Future<List<Post>> getPostList() async {
    var uri = 'http://167.179.106.185/posts';
    final response = await http.get(Uri.parse(uri));
    try {
      if (response.statusCode == 200) {
        return jsonDecode(response.body)
          .map<Post>((json) => Post.fromJson(json))
          .toList();
      } else {
        throw Exception('failed to load post');
      }
    } catch (e) {
      throw Exception('failed to load post');
    }
  }

  Future<dynamic> getPostDetail(id) async {
    var uri = 'http://167.179.106.185/post/' + id.toString();
    // print(uri);
    final response = await http.get(Uri.parse(uri));
    // print(response);
    try {
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        // print(result['post']);
        // var user = result['user'].map<User>((json) => User.fromJson(json));
        var user = User.fromJson(result['user']);
        var post = Post.fromJson(result['post']);
        var reviews = result['reviews']
          .map<Review>((json) => Review.fromJson(json))
          .toList();
        return {
          'user': user,
          'post': post,
          'reviews': reviews,
        };

      } else {
        throw Exception('failed to load post');
      }
    } catch (e) {
      print(e);
      throw Exception('failed to load post');
    }
  }

  Future<Post> createPost(String code, String comment, int userId) async {
    final response = await http.post(
      Uri.parse('http://167.179.106.185/post'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String> {
        'code': code, 'comment': comment, 'userId': userId.toString(),
      })
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create post.');
    }
  }


  Future<Review> createReview(String point, String comment, int userId, int postId) async {
    final response = await http.post(
      Uri.parse('http://167.179.106.185/review'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String> {
        'point': point, 'comment': comment, 'userId': userId.toString(), 'postId': postId.toString()
      })
    );

    if (response.statusCode == 200) {
      return Review.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create review.');
    }
  }

  Future<dynamic> getFollows(id) async {
    final prefs = await SharedPreferences.getInstance();
    final loginId = prefs.getString('login_user_id') as String;

    var uri = 'http://167.179.106.185/follows/' + id.toString() + '/' + loginId.toString();
    final response = await http.get(Uri.parse(uri));
    try {
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var followings = result['followings']
          .map<User>((json) => User.fromJson(json))
          .toList();

        var followers = result['followers']
          .map<User>((json) => User.fromJson(json))
          .toList();

        return {
          'followings': followings,
          'followers': followers,
        };

      } else {
        throw Exception('failed to load post');
      }
    } catch (e) {
      print(e);
      throw Exception('failed to load post');
    }
  }

  Future<dynamic> createFollow(int userId, int followerId) async {
    final response = await http.post(
      Uri.parse('http://167.179.106.185/follow'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String> {
        'userId': userId.toString(), 'followerId': followerId.toString()
      })
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create review.');
    }
  }

  Future<User> getUser(id) async {
    final prefs = await SharedPreferences.getInstance();
    final loginId = prefs.getString('login_user_id') as String;
    print('<<<< Get User Login ID >>>>');
    print(loginId);
    var uri = 'http://167.179.106.185/user/' + id.toString() + '/' + loginId;
    final response = await http.get(Uri.parse(uri));
    try {
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);
        var user = User.fromJson(result);
        print(user);
        print('<-- Get User -->');

        return user;
      } else {
        throw Exception('failed to load user json');
      }
    } catch (e) {
      print(e);
      throw Exception('failed to load user catch');
    }
  }

  Future<List<Post>> getUserPostList(id) async {
    var uri = 'http://167.179.106.185/user/posts/' + id.toString();
    final response = await http.get(Uri.parse(uri));
    try {
      if (response.statusCode == 200) {
        return jsonDecode(response.body)
          .map<Post>((json) => Post.fromJson(json))
          .toList();
      } else {
        throw Exception('failed to load post');
      }
    } catch (e) {
      throw Exception('failed to load post');
    }
  }

  Future<List<Review>> getUserReviewList(id) async {
    var uri = 'http://167.179.106.185/user/reviews/' + id.toString();
    final response = await http.get(Uri.parse(uri));
    try {
      if (response.statusCode == 200) {
        return jsonDecode(response.body)
          .map<Review>((json) => Review.fromJson(json))
          .toList();
      } else {
        throw Exception('failed to load post');
      }
    } catch (e) {
      throw Exception('failed to load post');
    }
  }
  
  Future<User> profile(int userId, String name) async {
    final response = await http.post(
      Uri.parse('http://167.179.106.185/profile'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String> {
        'name': name, 'userId': userId.toString(),
      })
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create review.');
    }
  }

  Future<User> register(String email, String displayName, String photoUrl, String g_id) async {
    print({
        'email': email, 'displayName': displayName, 'photoUrl': photoUrl, 'id': g_id,
      });
    final response = await http.post(
      Uri.parse('http://167.179.106.185/register'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String> {
        'email': email, 'displayName': displayName, 'photoUrl': photoUrl, 'id': g_id,
      })
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create review.');
    }
  }
}