class Post {
  int? userId;
  int? id;
  String? code;
  String? comment;

  Post({this.userId, this.id, this.code, this.comment});

  factory Post.fromJson(Map<String, dynamic> json) {
    print(json);
    return Post(userId: json['userId'], id: json['id'], code: json['code'], comment: json['comment']);
  }
}