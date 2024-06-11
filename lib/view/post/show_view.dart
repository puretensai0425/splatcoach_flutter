import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splatcoach/model/review.dart';
import 'package:splatcoach/screen/post/list_screen.dart';
import 'package:splatcoach/screen/user/show_screen.dart';
import 'package:splatcoach/view/review/create_view.dart';
import 'package:splatcoach/viewModel/postShowModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostShowView extends StatefulWidget {
  const PostShowView({super.key});

  @override
  State<PostShowView> createState() => _PostShowViewState();
}

class _PostShowViewState extends State<PostShowView> {
  dynamic postDetail;
  // late List<Review> _reviewList;

  late int loginUserId;

  @override
  void initState() {
    super.initState();
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
        title: const Text("スプラコーチ"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PostListScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      
      body: Consumer<PostShowModel> (
        builder: (context, provider, child) {
          final user = provider.postDetail?['user'];
          final post = provider.postDetail?['post'];

          final _reviewList = provider.postDetail?['reviews'];

          return provider.postDetail == null 
            ? Center(child: CircularProgressIndicator())
            : Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserShowScreen(userId: user.id),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage("${user.photoUrl}"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("コード：${post.code}"),
                          Text("コメント：${post.comment}")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              loginUserId != post.userId ?
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewCreateView(postId: post.id),
                    ),
                  );
                }, 
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "採点する",
                    style: TextStyle(
                      fontSize: 18,
                    )
                  ),  
                ),
              ) : const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              Text("採点結果"),
              
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _reviewList.length,
                  
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserShowScreen(userId: _reviewList[index].userId),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage("${_reviewList[index].photoUrl}"),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Container(
                            width: 10,
                            height: 10,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${_reviewList[index].userName}"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 40,
                                        height: 30,
                                        color: Colors.orange,
                                        child: Text("${_reviewList[index].point}点"),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(3),
                                      child: Text("${_reviewList[index].comment}"),
                                    )
                                    
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      
                    );
                  },
                ),
              ),
            ],
          );
          
        },
      ),
    );
  }
}