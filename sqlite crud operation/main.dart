import 'package:flutter/material.dart';
import 'package:module5/sqlite%20crud%20operation/user_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: UserListScreens(),
    );
  }
}
