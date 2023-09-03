import 'package:flutter/material.dart';
import 'package:module5/sqlite%20crud%20operation/database/db_helper.dart';
import 'package:module5/sqlite%20crud%20operation/model/user.dart';

class UserScreen extends StatefulWidget {
User? user;
UserScreen({this.user});

  @override
  State<UserScreen> createState() => _UserScreenState(user);
}

class _UserScreenState extends State<UserScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  User? user;
  _UserScreenState(this.user);
  DbHelper _dbHelper = DbHelper();

  Future<void> addUser(User user,BuildContext context) async {
    try{
      var id = await _dbHelper.insert(user);
      if(id!=-1) {
        print('User Added successfully');
        Navigator.pop(context,user);
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> updateUser(User user,BuildContext context) async {
    try{
      var id = await _dbHelper.update(user);
      if(id!=1) {
        print('User updated successfully');
        Navigator.pop(context,user);
      }
    }catch(e) {
      print(e.toString());
    }
  }

  void initState() {
    if(user != null) {
      _nameController.text = user!.name ?? '';
      _emailController.text = user!.email ?? '' ;
      _ageController.text = user!.age.toString() ?? '' ;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user == null ? 'Add User' : 'Update User'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(hintText: 'Enter the name:'),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(hintText: 'Enter the Email:'),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(hintText: 'Enter the Age:'),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(onPressed: () {
                        String name = _nameController.text.toString().trim();
                        String email = _emailController.text.toString().trim();
                        int age = int.parse(_ageController.text.toString().trim());
                        if(user!=null) {
                          //Update
                          User mUser = User.withId(name: name,email: email,age: age,id: user!.id,date: user!.date);
                          updateUser(mUser, context);
                        } else {
                          User user = User(name: name, email: email, age: age);
                          addUser(user, context);
                          print('name : ${user.name}     email : ${user
                              .email}    age : ${user.age}    date : ${user
                              .date}    id : ${user.id}');
                        }
                      },
                        child: Text(user == null ? 'Add User' : 'Update User'),
                      ),
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}