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
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return LoginScreen();

            }));
          }, icon:Icon(Icons.logout) ),

        ],
      ),
    );
  }
}
