import 'package:firebase_practice/screens/add_task_screen.dart';
import 'package:firebase_practice/screens/login_screen.dart';
import 'package:firebase_practice/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return AddTaskScreen();

        }));
      }, child: Icon(Icons.add),),
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: Text("DASHBOARD"),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return ProfileScreen();

            }));
          }, icon:Icon(Icons.person) ),
          IconButton(onPressed: (){

            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text('Confirmation'),
                content: Text('Are you sure to LogOut ?'),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text('NO'))  ,
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();

                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return LoginScreen();

                    }));
                  }, child: Text('YES'))  ,
                ],
              );
            });



          }, icon:Icon(Icons.logout) ),

        ],
      ),
    );
  }
}
