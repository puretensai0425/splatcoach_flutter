import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splatcoach/view/post/list_view.dart';
import 'package:splatcoach/viewModel/postListModel.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostListModel(),
      child: const PostListView(),
    );
  }
}