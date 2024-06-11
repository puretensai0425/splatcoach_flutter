import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splatcoach/view/user/post_view.dart';
import 'package:splatcoach/viewModel/userPostModel.dart';

class UserPostScreen extends StatefulWidget {
  const UserPostScreen({super.key, required this.userId});
  final int? userId;

  @override
  State<UserPostScreen> createState() => _UserPostScreenState();
}

class _UserPostScreenState extends State<UserPostScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = widget.userId;
    return ChangeNotifierProvider(
      create: (context) => UserPostModel(userId),
      child: UserPostView(userId: userId,),
    );
  }
}