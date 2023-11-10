import 'package:flutter/material.dart';
import 'package:todo/utils/todo_tile.dart';

class TodoLists extends StatelessWidget {
  final todoLists;

  TodoLists({
    super.key,
    required this.todoLists
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: todoLists.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: todoLists[index][0],
            taskCompleted: todoLists[index][1],
            onChanged: (value) => {},
            deleteFunction: (context) => {},
          );
        },
      ),
    );
  }
}