import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splatcoach/view/user/profile_view.dart';
import 'package:splatcoach/viewModel/userShowModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key, required this.userId});
  final int? userId;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final userId = widget.userId;
    return ChangeNotifierProvider(
      create: (context) => UserShowModel(userId),
      child: UserProfileView(),
    );
  }
}