import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/screens/add_task_screen.dart';
import 'package:firebase_practice/screens/login_screen.dart';
import 'package:firebase_practice/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // fetch todos from firestore database

  CollectionReference? taskReference;

  @override
  void initState() {
    super.initState();

    taskReference = FirebaseFirestore.instance
        .collection('tasks')
        .doc(FirebaseAuth.instance.currentUser!.uid!)
        .collection('tasks');
  }


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
                  TextButton(onPressed: () async {
                    Navigator.of(context).pop();

                    await FirebaseAuth.instance.signOut();

                    // current screen is Dashboard
                    // it will removed from the navigation stack
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                      return LoginScreen();

                    }));
                  }, child: Text('YES'))  ,
                ],
              );
            });



          }, icon:Icon(Icons.logout) ),

        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: taskReference!.snapshots(),
          builder: (context, snapshot){

            if( snapshot.hasData){

              var streamData = snapshot.data;

              List<QueryDocumentSnapshot> documents = streamData!.docs;

              if( documents.isEmpty){
                return Center(child: Text("No Todos Yet"));
              }

              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index){

                    QueryDocumentSnapshot taskDocument = documents[index];

                    return ListTile(
                      leading: Checkbox(value: taskDocument['isCompleted'], onChanged: (bool? checked){

                      }),

                      title: Text(taskDocument['taskName']),
                      subtitle: Text(taskDocument['createdOn'].toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                        ],
                      ),
                    );

                  });


            }else{
              return Center(child: SpinKitPumpingHeart(color: Colors.green,),);
            }
          }),
    );
  }
}
