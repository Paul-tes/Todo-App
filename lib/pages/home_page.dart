// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';
import 'package:todo/constants/Colors.dart';
import 'package:todo/utils/dialog_box.dart';
import 'package:todo/utils/search_input.dart';
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
      backgroundColor: myBGColor,
      appBar: _buildAppBar(),

      drawer: Drawer(
        backgroundColor: Colors.green,
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.today_outlined,
                size: 48,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            SearchInput(),
            Container(
              margin: EdgeInsets.only(
                top: 50,
                bottom: 20,
              ),
              child: Text(
                "All ToDos",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: db.todoList.length,
                itemBuilder: (context, index) {
                  return ToDoTile(
                    taskName: db.todoList[index][0],
                    taskCompleted: db.todoList[index][1],
                    onChanged: (value) => checkBoxChanged(index),
                    deleteFunction: (context) => deleteTask(index),
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: myBlack),
      backgroundColor: myBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Let's Do it",
            style: TextStyle(color: myBlack),
          ),

          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/me.JPG'),
            ),
          ),
        ],
      ),
      elevation: 0,
    );
  }
}