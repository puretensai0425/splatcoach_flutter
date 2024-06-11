import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:splatcoach/model/user.dart';
import 'package:splatcoach/viewModel/userFollowModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserFollowView extends StatefulWidget {
  const UserFollowView({super.key, required this.userId, required this.userName});
  final int? userId;
  final String? userName;

  @override
  State<UserFollowView> createState() => _UserFollowViewState();
}

class _UserFollowViewState extends State<UserFollowView> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  late List<User> followings;
  late List<User> followers;
  late UserFollowModel _userFollowModel;
  late int? _userId;
  late String? _userName;
  late int loginUserId;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    // _userFollowModel = UserFollowModel();
    _userFollowModel = Provider.of<UserFollowModel>(context, listen: false);
    _userId = widget.userId;
    _userName = widget.userName;

    loadLoginUserId();
  }

  Future<void> loadLoginUserId() async {
    final prefs = await SharedPreferences.getInstance();
    loginUserId = int.parse(prefs.getString('login_user_id') as String);
    print(loginUserId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_userName as String),
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

        bottom: TabBar(
          labelColor: Colors.black,
          indicatorColor: Colors.blue,
          controller: _tabController, 
          tabs: const [
            Tab(
              text: "Followers"
            ),
            Tab(
              text: "Following"
            ),
          ],
        ),
      ),
      body: Consumer<UserFollowModel>(
        builder: (context, provider, child) {

          final followings = provider.userFollows?['followings'];
          final followers = provider.userFollows?['followers'];

          return provider.userFollows == null 
            ? Center(child: CircularProgressIndicator())
            :TabBarView(
            controller: _tabController,
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemCount: followers.length,
                itemBuilder: (context, index) {
                  return UserFollowContainer(id: followers[index].id, name: followers[index].name, photoUrl: followers[index].photoUrl, comment: followers[index].comment, following: followers[index].following);
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: followings.length,
                itemBuilder: (context, index) {
                  return UserFollowContainer(id: followings[index].id, name: followings[index].name, photoUrl: followings[index].photoUrl, comment: followings[index].comment, following: followings[index].following);
                },
              ),
            ],
          );
        },
      )
    );
  }

  Container UserFollowContainer({int id=1, String name="User1", String photoUrl="https://lh6.googleusercontent.com/-LydP0Sbut3w/AAAAAAAAAAI/AAAAAAAACWM/_EyzlerakeE/photo.jpg?sz=64", String comment="Comment1", int following=1}) {
    late String following_text;
    if (following == 1) {
      following_text = "Unfollow";
    } else {
      following_text = "Follow";
    }
      
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey)
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(photoUrl),
            backgroundColor: Colors.transparent,
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width - 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                Text(comment),
              ],
            ),
          ),
          loginUserId != id?
          Container(
            width: 100,
            child: ElevatedButton(
              onPressed: () {
                _userFollowModel.createFollow(_userId, id);
              }, 
              child: Container(
                // padding: const EdgeInsets.all(10),
                child: Text(
                  following_text,
                  style: const TextStyle(
                    fontSize: 12,
                  )
                ),  
              ),
            ),
          ) : Container(
            width: 100
          ),
        ]
      )
    );
  }
}