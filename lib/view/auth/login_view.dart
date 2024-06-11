import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:splatcoach/repository/userRepository.dart';
import 'package:splatcoach/screen/post/list_screen.dart';
import 'package:splatcoach/viewModel/postListModel.dart';
import '../../src/sign_in_button.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // clientId: '541201308540-bvmm5enategg84gsjndbm4hjcch1jpbp.apps.googleusercontent.com',
  scopes: scopes,
);

class AuthLoginView extends StatefulWidget {
  const AuthLoginView({super.key});

  @override
  State<AuthLoginView> createState() => _AuthLoginViewState();
}

class _AuthLoginViewState extends State<AuthLoginView> {
  
  // GoogleSignInAccount? _currentUser;
  // bool _isAuthorized = false;

  // final SharedPreferences _prefs = await SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    // _initPref();

    _googleSignIn.onCurrentUserChanged
      .listen((GoogleSignInAccount? account) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        bool isAuthorized = account != null;
        if (kIsWeb && account != null) {
          isAuthorized = await _googleSignIn.canAccessScopes(scopes);
        }

        print(account);

        String? email = account?.email;
        String? displayName = account?.displayName;
        String? photoUrl = account?.photoUrl;
        String? g_id = account?.id;
        // _prefs = await SharedPreferences.getInstance();
        
        if (email != null) {
          final _userRepository = UserRepository();
          final user = _userRepository.register(email, displayName, photoUrl, g_id);
          int userId;
          user.then((result) {
            userId = result.id ?? -1;
            if (userId > 0) {
              print("Before Set Login Id");
              print(userId);
              setLoginId(userId);
              // prefs.setString('login_user_id', userId.toString());
              // setState(() {
              //   _prefs.setString('login_user_id', userId.toString());
              // });
              print("Before Navigator Push");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostListScreen(),
                ),
              );
            }
          });
        }
        
      });
      
    _googleSignIn.signInSilently();
  }

  Future<void> setLoginId(login_user_id) async {
    print(login_user_id);
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('login_user_id', login_user_id.toString());
    });
  }
  // _initPref() async {
  //   _prefs = await SharedPreferences.getInstance();
  // }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  // Future<void> _handleAuthorizeScopes() async {
  //   final bool isAuthorized = await _googleSignIn.requestScopes(scopes);
    
  //   setState(() {
  //     _isAuthorized = isAuthorized;
  //   });
  // }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        // See: src/sign_in_button.dart
        buildSignInButton(
          onPressed: _handleSignIn,
        ),

        // buildSignInButton(
        //   onPressed: _handleSignOut,
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('splatcoach'),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      )
    );
  }
}