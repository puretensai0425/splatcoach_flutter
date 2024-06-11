import 'package:flutter/material.dart';
import 'package:splatcoach/repository/postRepository.dart';
import 'package:splatcoach/screen/post/show_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewCreateView extends StatefulWidget {
  const ReviewCreateView({super.key, required this.postId});
  final int? postId;

  @override
  State<ReviewCreateView> createState() => _ReviewCreateViewState();
}

class _ReviewCreateViewState extends State<ReviewCreateView> {
  
  final _key = GlobalKey<FormState>();
  late String _point, _comment;

  late int loginUserId;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("5点"), value: "5"),
      DropdownMenuItem(child: Text("4点"), value: "4"),
      DropdownMenuItem(child: Text("3点"), value: "3"),
      DropdownMenuItem(child: Text("2点"), value: "2"),
      DropdownMenuItem(child: Text("1点"), value: "1"),
    ];
    return menuItems;
  }


  @override
  void initState() {
    super.initState();
    loadLoginUserId();
  }

  Future<void> loadLoginUserId() async {
    final prefs = await SharedPreferences.getInstance();
    loginUserId = int.parse(prefs.getString('login_user_id') as String);
    print(loginUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("採点"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _key,
          child: Column(
            children: [
              // codeInput(),
              pointSelect(),
              const SizedBox(
                height: 15,
              ),
              commentInput(),
              const SizedBox(
                height: 15,
              ),
              submitButton(),
            ],
          ),
        )
      ),
      // backgroundColor: Colors.grey,
    );
  }

  Widget pointSelect() {
    String dropdownvalue = '5';
    _point = '5';

    return DropdownButtonFormField(
      autofocus: true,
      value: dropdownvalue,
      items: dropdownItems, 
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue= newValue!;
        });
      },
      onSaved: (point) => _point = point as String,
      decoration: const InputDecoration(
        hintText: '点数を選択してください！',
        labelText: '点数',
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

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_key.currentState!.validate()) {
          _key.currentState!.save();

          final postId = widget.postId;
          final _postRepository = PostRepository();
          final post = _postRepository.createReview(_point, _comment, loginUserId, postId);
          
          post.then((result) {
            final reviewId = result.id ?? -1;
            print(reviewId);
            if (reviewId > 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostShowScreen(postId: postId),
                ),
              );
            }
          });

        }
      }, 
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(
          "完了",
          style: TextStyle(
            fontSize: 18,
          )
        ),
      ),
    );
  }
}