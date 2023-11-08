// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todo/utils/my_button.dart';


class DialogBox extends StatelessWidget {
  const DialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add new Task",
              ),
            ),
            
            // save and cancel button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                // save button
                MyButton(text: "Save", onPressed: () {}),

                SizedBox(width: 8,),

                // cancel button
                MyButton(text: "Cacel", onPressed: () {})

              ],
            )
          ],
        ),
      ),
    );
  }
}