import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'TodoList.dart';
void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Todo List'),
            centerTitle: true,
            backgroundColor:Colors.grey[700],
          ),
          body:Container(
            color:Colors.grey,
            child:LoginPage(),)

      ),
    );
  }
}

