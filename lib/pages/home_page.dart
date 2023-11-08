import 'package:flutter/material.dart';
import 'package:todo/utils/todo_tile.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List todoList = [
    ["Task one wag", false],
    ["Do exersise task two", false]
  ];

  // check box tabed
  void checkBoxChanged(int index) {
    setState(() {
      todoList[index][1] = ! todoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("To Do"),
        elevation: 0,
      ),

      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: todoList[index][0],
            taskCompleted: todoList[index][1],
            onChanged: (value) => checkBoxChanged(index),
          );
        },
      ),
    );
  }
}