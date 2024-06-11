import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splatcoach/model/user.dart';
import 'package:splatcoach/screen/user/follow_screen.dart';
import 'package:splatcoach/screen/user/post_screen.dart';
import 'package:splatcoach/screen/user/profile_screen.dart';
import 'package:splatcoach/screen/user/review_screen.dart';
import 'package:splatcoach/viewModel/userShowModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserShowView extends StatefulWidget {
  const UserShowView({super.key, required this.userId});
  final int? userId;

  @override
  State<UserShowView> createState() => _UserShowViewState();
}

class _UserShowViewState extends State<UserShowView> {
  late UserShowModel _userShowModel;
  late int? _userId;
  late User _user;

  late int loginUserId;


  @override
  void initState() {
    super.initState();

    _userShowModel = Provider.of<UserShowModel>(context, listen: false);
    _userId = widget.userId;

    loadLoginUserId();
  }

  Future<void> loadLoginUserId() async {
    final prefs = await SharedPreferences.getInstance();
    loginUserId = int.parse(prefs.getString('login_user_id') as String);
    print(loginUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("採点"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, 'refresh');
          },
          child: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<UserShowModel>(
        builder: (context, provider, child) {
          _user = provider.userDetail;

          return _user.name == null
            ? Center(child: CircularProgressIndicator(),)
            : Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (loginUserId == _userId) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfileScreen(userId: loginUserId,),
                          ),
                        );
                      }
                    },
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage("${_user.photoUrl}"),
                        backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text("${_user.name}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Center(
                  child: Text("${_user.comment}", style: const TextStyle(fontSize: 14)),
                ),
                const SizedBox(
                  height: 5,
                ),
                loginUserId != _userId ?
                ElevatedButton(
                  onPressed: () {
                    _userShowModel.createFollow(_userId);
                  }, 
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      _user.following == 1 ? "Unfollow" : "Follow",
                      style: const TextStyle(
                        fontSize: 14,
                      )
                    ),  
                  ),
                ) : const SizedBox(
                  height: 5,
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserFollowScreen(userId: _userId, userName: _user.name,),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top:20),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          child: Text("${_user.followingCnt} Following"),
                        ),
                        Container(
                          width: 100,
                          height: 30,
                          child: Text("${_user.followerCnt} Followers"),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 10,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.black26,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserReviewScreen(userId: _userId,),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                    ),
                    child: Text("回答履歴"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserPostScreen(userId: _userId,),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                    ),
                    child: Text("依頼履歴"),
                  ),
                ),
              ],
              
            );
        },
      )
    );
  }
}