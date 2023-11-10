import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List todoList = [];

  // reference hive box
  final _myBox = Hive.box('myBox');

  // run createInitialData if the app starts ever the first time.
  void createInitialData() {
    todoList = [
      ["Task one here", false],
      ["Task two becha", false]
    ];
  }


  // load the data from database
  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }


  // update the database
  void updateData() {
    _myBox.put("TODOLIST", todoList);
  }
}