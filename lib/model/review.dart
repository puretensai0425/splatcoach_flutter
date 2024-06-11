class Review {
  int? id;
  int? userId;
  String? userName;
  String? photoUrl;
  int? postId;
  int? point;
  String? comment;
  

  Review({this.id, this.userId, this.userName, this.photoUrl, this.postId, this.point, this.comment});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(id: json['id'], userId: json['userId'], userName: json['userName'], photoUrl: json['photoUrl'], postId: json['postId'], point: json['point'], comment: json['comment']);
  }
}