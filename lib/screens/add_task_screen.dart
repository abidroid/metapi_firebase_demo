import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: Text("ADD TASK"),
      ),body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 20,
        children: [
          TextField(

            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Add Task",
            ),),

          ElevatedButton(onPressed: (){}, child: Text("Save"))
        ],
            ),
      ),
    );
  }
}
