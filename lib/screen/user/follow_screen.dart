import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splatcoach/view/user/follow_view.dart';
import 'package:splatcoach/viewModel/userFollowModel.dart';

class UserFollowScreen extends StatefulWidget {
  const UserFollowScreen({super.key, required this.userId, required this.userName});
  final int? userId;
  final String? userName;

  @override
  State<UserFollowScreen> createState() => _UserFollowScreenState();
}

class _UserFollowScreenState extends State<UserFollowScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = widget.userId;
    final userName = widget.userName;
    return ChangeNotifierProvider(
      create: (context) => UserFollowModel(userId),
      child: UserFollowView(userId: userId, userName: userName,),
    );
  }
}