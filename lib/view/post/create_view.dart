import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:splatcoach/model/post.dart';
import 'package:splatcoach/repository/postRepository.dart';
import 'package:splatcoach/screen/post/list_screen.dart';
import 'package:splatcoach/screen/post/show_screen.dart';
import 'package:splatcoach/view/post/list_view.dart';
import 'package:splatcoach/viewModel/postListModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostCreateView extends StatefulWidget {
  const PostCreateView({super.key});

  @override
  State<PostCreateView> createState() => _PostCreateViewState();
}

class _PostCreateViewState extends State<PostCreateView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // int _selectedIndex = 0;

  final _key = GlobalKey<FormState>();
  late String _code, _comment;

  late int loginUserId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    // _tabController.addListener(
    //   () => setState(() => _selectedIndex = _tabController.index)
    // );
    loadLoginUserId();
  }

  Future<void> loadLoginUserId() async {
    final prefs = await SharedPreferences.getInstance();
    loginUserId = int.parse(prefs.getString('login_user_id') as String);
    print(loginUserId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("投稿"),
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
      bottomNavigationBar: SizedBox(
        // height: 80,
        child: TabBar(
          onTap: (value) async {
            if (value == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostListScreen(),
                ),
              );
              
              // if (refresh == 'refresh') {
              //   _tabController.animateTo(0);
              // }
            }
          },
          indicatorColor: Colors.transparent,
          labelColor: Colors.blue,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.home_outlined),
            ),
            Tab(
              icon: Icon(Icons.note_add),
            ),
            Tab(
              icon: Icon(Icons.account_circle_outlined),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _key,
          child: Column(
            children: [
              codeInput(),
              const SizedBox(
                height: 15,
              ),
              commentInput(),
              const SizedBox(
                height: 15,
              ),
              submitButton(context),
            ],
          ),
        )
      ),
    );
  }

  Widget codeInput() {
    return TextFormField(
      autofocus: true,
      validator: (val) {
        if (val!.isEmpty) {
          return 'コードは必須です。';
        } else {
          return null;
        }
      },
      onSaved: (code) => _code = code as String,
      decoration: const InputDecoration(
        hintText: 'コードを入力してください！',
        labelText: 'コード',
        labelStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        floatingLabelAlignment: FloatingLabelAlignment.center,
        contentPadding: EdgeInsets.all(5),
      ),
    );
  }


  Widget commentInput() {
    return TextFormField(
      // autofocus: true,
      validator: (val) {
        if (val!.isEmpty) {
          return 'コメントは必須です。';
        } else {
          return null;
        }
      },
      onSaved: (comment) => _comment = comment as String,
      decoration: const InputDecoration(
        hintText: 'コメントを入力してください！',
        labelText: 'コメント',
        labelStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        floatingLabelAlignment: FloatingLabelAlignment.center,
        contentPadding: EdgeInsets.all(5),
      ),
    );
  }

  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_key.currentState!.validate()) {
          _key.currentState!.save();
          
          final _postRepository = PostRepository();
          final post = _postRepository.createPost(_code, _comment, loginUserId);

          post.then((result) {
            final postId = result.id ?? -1;
            print(postId);
            if (postId > 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostShowScreen(postId: postId),
                ),
              );
            }
            print(result.id);
          });
          
        }
      }, 
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(
          "依頼",
          style: TextStyle(
            fontSize: 18,
          )
        ),
      ),
    );
  }

}