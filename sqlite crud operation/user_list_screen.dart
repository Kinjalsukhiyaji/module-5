import 'package:flutter/material.dart';

import 'user-screen.dart';
import 'database/db_helper.dart';
import 'model/user.dart';

class UserListScreens extends StatefulWidget {
  const UserListScreens({super.key});

  @override
  State<UserListScreens> createState() => _UserListScreensState();
}

class _UserListScreensState extends State<UserListScreens> {
  List<User> userList = [];
  DbHelper _dbHelper = DbHelper();
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserList();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List Screen'),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context,index) {
          return ListTile(
            onTap: () async {
              var user = await Navigator.push(context, MaterialPageRoute(builder: (context) => UserScreen(user:userList[index],
              ),
              ),
              );
              if(user is User) {
                var index = userList.indexWhere((element) => element.id == user.id);
                setState(() {
                  userList[index] = user;
                });
              }
            },
            leading: CircleAvatar(
              backgroundColor: Colors.pink.shade200,
              child: Icon(
                Icons.ac_unit,
                color: Colors.pink,
              ),
            ),
            title: Text(userList[index].name!),
            subtitle: Text(userList[index].email!),
            trailing: IconButton(
              onPressed: () async   {
                await _dbHelper.remove(userList[index].id!);
                //print('item id : ${userList[index].id}');
              },
              icon: Icon(Icons.delete),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var user = await  Navigator.push(context, MaterialPageRoute(builder: (context) => UserScreen(),
          ),
          );
          if(user is User) {
            setState(() {
              userList.add(user);
            });
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> loadUserList() async {
    var tempList = await _dbHelper.getUserList();
    setState(() {
      userList=tempList as List<User>;
    });
  }
}