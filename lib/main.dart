import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
// import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/profile.dart';
import 'package:flutter_application_1/screens/todoPage.dart';

import 'model/todo.dart';

void main() {
  runApp(MyApp());
}

final todosList = Todo.todoList();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("AddMe"),
              Builder(builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyProfile()));
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('assets/images/Bobo.jpg'),
                            fit: BoxFit.cover)),
                  ),
                );
              }),
            ],
          ),
        ),
        body: Home(),
      ),
    );
  }
}
