import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:splatcoach/view/post/show_view.dart';
import 'package:splatcoach/viewModel/postShowModel.dart';

class PostShowScreen extends StatefulWidget {
  const PostShowScreen({super.key, required this.postId});
  final int? postId;

  @override
  State<PostShowScreen> createState() => _PostShowScreenState();
}

class _PostShowScreenState extends State<PostShowScreen> {
  @override
  Widget build(BuildContext context) {
    final postId = widget.postId;
    return ChangeNotifierProvider(
      create: (context) => PostShowModel(postId),
      child: PostShowView(),
    );
  }
}