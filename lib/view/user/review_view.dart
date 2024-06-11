import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splatcoach/model/review.dart';
import 'package:splatcoach/screen/post/show_screen.dart';
import 'package:splatcoach/viewModel/userReviewModel.dart';

class UserReviewView extends StatefulWidget {
  const UserReviewView({super.key, required this.userId});
  final int? userId;

  @override
  State<UserReviewView> createState() => _UserReviewViewState();
}

class _UserReviewViewState extends State<UserReviewView> {
  late List<Review> userReview;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("回答履歴"),
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
      body: Consumer<UserReviewModel>(
        builder: (context, provider, child) {
          userReview = provider.userReview;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: userReview.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostShowScreen(postId: userReview[index].postId),
                    ),
                  );
                  print("Clicked ${userReview[index].postId}");
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
                        "ポイント：${userReview[index].point}",
                      ),
                      Text(
                        "コメント：${userReview[index].comment}",
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