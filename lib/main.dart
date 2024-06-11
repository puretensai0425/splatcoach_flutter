import 'package:flutter/material.dart';
import 'package:splatcoach/screen/post/list_screen.dart';
import 'package:splatcoach/screen/post/show_screen.dart';
import 'package:splatcoach/screen/user/follow_screen.dart';
import 'package:splatcoach/screen/user/post_screen.dart';
import 'package:splatcoach/screen/user/profile_screen.dart';
import 'package:splatcoach/screen/user/review_screen.dart';
import 'package:splatcoach/screen/user/show_screen.dart';
import 'package:splatcoach/view/auth/login_view.dart';
import 'package:splatcoach/view/post/create_view.dart';
import 'package:splatcoach/view/review/create_view.dart';
import 'package:splatcoach/view/user/follow_view.dart';
import 'package:splatcoach/view/user/profile_view.dart';


void main() {
  runApp(const MaterialApp(
    // home: UserShowScreen(userId: 3,)
    home: AuthLoginView(),
    
  ));
}
