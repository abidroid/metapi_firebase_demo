import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  var taskC = TextEditingController();

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
            controller: taskC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Add Task",
            ),),

          ElevatedButton(onPressed: () async {


            String userId = FirebaseAuth.instance.currentUser!.uid!;

            String taskName = taskC.text.trim();

            FirebaseFirestore database = FirebaseFirestore.instance;

            var taskDocument = database.collection('tasks')
                .doc(userId)
                .collection('tasks')
                .doc();

            await taskDocument.set({
              'taskName': taskName,
              'createdOn': FieldValue.serverTimestamp(),
              'isCompleted': false,
              'taskId': taskDocument.id,
            });

            Fluttertoast.showToast(msg: 'Task Created');
          }, child: Text("Save"))
        ],
            ),
      ),
    );
  }
}
