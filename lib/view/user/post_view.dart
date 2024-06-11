import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splatcoach/model/post.dart';
import 'package:splatcoach/screen/post/show_screen.dart';
import 'package:splatcoach/viewModel/userPostModel.dart';

class UserPostView extends StatefulWidget {
  const UserPostView({super.key, required this.userId});
  final int? userId;

  @override
  State<UserPostView> createState() => _UserPostViewState();
}

class _UserPostViewState extends State<UserPostView> {
  late List<Post> userPost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("依頼履歴"),
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
      body: Consumer<UserPostModel>(
        builder: (context, provider, child) {
          userPost = provider.userPost;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: userPost.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostShowScreen(postId: userPost[index].id),
                    ),
                  );
                  print("Clicked ${userPost[index].id}");
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "コード：${userPost[index].code}",
                      ),
                      Text(
                        "コメント：${userPost[index].comment}",
                      ),
                    ],
                  ),
                  
                  
                ),
              );
            },
          );
        }
      ),

    );
  }
}