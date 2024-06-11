class User {
  int? id;
  String? name;
  String? email;
  String? photoUrl;
  String? comment;
  int? following;
  int? followingCnt;
  int? followerCnt;

  User({this.id, this.name, this.email, this.photoUrl, this.comment, this.following, this.followingCnt, this.followerCnt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], 
      name: json['name'], 
      email: json['email'], 
      photoUrl: json['photoUrl'], 
      comment: json['comment'], 
      following: json['following'], 
      followingCnt: json['followingCnt'],
      followerCnt: json['followerCnt'],
    );
  }
}