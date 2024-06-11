import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splatcoach/view/user/show_view.dart';
import 'package:splatcoach/viewModel/userShowModel.dart';

class UserShowScreen extends StatefulWidget {
  const UserShowScreen({super.key, required this.userId});
  final int? userId;

  @override
  State<UserShowScreen> createState() => _UserShowScreenState();
}

class _UserShowScreenState extends State<UserShowScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = widget.userId;
    return ChangeNotifierProvider(
      create: (context) => UserShowModel(userId),
      child: UserShowView(userId: userId,),
    );
  }
}