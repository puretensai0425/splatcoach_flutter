import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splatcoach/model/post.dart';
import 'package:splatcoach/screen/post/show_screen.dart';
import 'package:splatcoach/screen/user/profile_screen.dart';
import 'package:splatcoach/screen/user/show_screen.dart';
import 'package:splatcoach/view/post/create_view.dart';
import 'package:splatcoach/view/user/profile_view.dart';
import 'package:splatcoach/viewModel/postListModel.dart';

class PostListView extends StatefulWidget {
  const PostListView({super.key});

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> with SingleTickerProviderStateMixin {
  late List<Post> postList;
  late TabController _tabController;
  int _selectedIndex = 0;

  late int loginUserId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(
      () => setState(() {
        _selectedIndex = _tabController.index;
        // print("Init State");
        // print(_selectedIndex);
      })
    );

    loadLoginUserId();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> loadLoginUserId() async {
    final prefs = await SharedPreferences.getInstance();
    loginUserId = int.parse(prefs.getString('login_user_id') as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("スプラコーチ"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: SizedBox(
        // height: 80,
        child: TabBar(
          onTap: (value) async {
            if (value == 1) {
              String refresh = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostCreateView(),
                ),
              );
              
              if (refresh == 'refresh') {
                _tabController.animateTo(0);
              }
            } else if (value == 2) {
              String refresh = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserShowScreen(userId: loginUserId),
                ),
              );
              
              if (refresh == 'refresh') {
                _tabController.animateTo(0);
              }
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
      body: Consumer<PostListModel>(
        builder: (context, provider, child) {
          postList = provider.postList;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: postList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostShowScreen(postId: postList[index].id),
                    ),
                  );
                  print("Clicked ${postList[index].id}");
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "コード：${postList[index].code}",
                      ),
                      Text(
                        "コメント：${postList[index].comment}",
                      ),
                    ],
                  ),
                  
                  
                ),
              );
            },
          );
        },
      ),
    );
  }
}