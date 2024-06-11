import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splatcoach/model/user.dart';
import 'package:splatcoach/repository/userRepository.dart';
import 'package:splatcoach/screen/user/show_screen.dart';
import 'package:splatcoach/viewModel/userShowModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {

  final _key = GlobalKey<FormState>();
  late String _name;
  late int loginUserId;
  late User _user;

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
        title: const Text("表示名編集"),
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
      body: Consumer<UserShowModel>(
        builder: (context, provider, child) {
          _user = provider.userDetail;
          
          return _user.name == null
            ? Center(child: CircularProgressIndicator(),)
            : Container(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  // codeInput(),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "現在：${_user.name}", 
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  nameInput(),
                  const SizedBox(
                    height: 15,
                  ),
                  submitButton(),
                ],
              ),
            )
          );
        }
      )
      // backgroundColor: Colors.grey,
    );
  }

  Widget nameInput() {
    return TextFormField(
      // autofocus: true,
      validator: (val) {
        if (val!.isEmpty) {
          return '表示名は必須です。';
        } else {
          return null;
        }
      },
      onSaved: (name) => _name = name as String,
      decoration: const InputDecoration(
        hintText: '新しい表示名',
        labelText: '表示名',
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

          final userId = loginUserId;

          final _userRepository = UserRepository();
          final user = _userRepository.profile(userId, _name);
          
          user.then((result) {
            final userId = result.id ?? -1;
            print(userId);
            if (userId > 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserShowScreen(userId: userId,),
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