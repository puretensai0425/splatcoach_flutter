import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splatcoach/view/user/review_view.dart';
import 'package:splatcoach/viewModel/userReviewModel.dart';

class UserReviewScreen extends StatefulWidget {
  const UserReviewScreen({super.key, required this.userId});
  final int? userId;

  @override
  State<UserReviewScreen> createState() => _UserReviewScreenState();
}

class _UserReviewScreenState extends State<UserReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = widget.userId;
    return ChangeNotifierProvider(
      create: (context) => UserReviewModel(userId),
      child: UserReviewView(userId: userId,),
    );
  }
}