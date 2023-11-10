import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';
import 'package:todo/utils/dialog_box.dart';
import 'package:todo/utils/todo_tile.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // reference the hive box
  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // when the user opens the for 1st time do the following\
    if(_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // if the data is already there
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  // check box tabed
  void checkBoxChanged(int index) {
    setState(() {
      db.todoList[index][1] = ! db.todoList[index][1];
    });
    db.updateData();
  }

  // save  new task method
  void savenewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateData();

    // clear pop up create new task modal
    Navigator.of(context).pop();
  }

  // creat new task method
  void createNewTask() {
    showDialog(
      context: context, builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: savenewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      }
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
  
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("To Do"),
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        ),

      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}