import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/screens/add_task_screen.dart';
import 'package:firebase_practice/screens/login_screen.dart';
import 'package:firebase_practice/screens/profile_screen.dart';
import 'package:firebase_practice/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../util/interstitial_ad_helper.dart';
import '../widgets/banner_ad_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // fetch todos from firestore database

  CollectionReference? taskReference;
  final InterstitialAdHelper _interstitialAdHelper = InterstitialAdHelper();

  @override
  void initState() {
    super.initState();

    taskReference = FirebaseFirestore.instance
        .collection('tasks')
        .doc(FirebaseAuth.instance.currentUser!.uid!)
        .collection('tasks');

    _interstitialAdHelper.loadAd(); // preload on init
  }

  @override
  void dispose() {
    _interstitialAdHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

        _interstitialAdHelper.showAd(
          onAdDismissed: () {
            // Navigate to AddTaskScreen after ad is dismissed
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const AddTaskScreen();
            }));
          },
        );

        // Navigator.of(context).push(MaterialPageRoute(builder: (context){
        //   return AddTaskScreen();
        //
        // }));
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

              return Column(
                children: [
                  const BannerAdWidget(), // 👈 placed at the top

                  Expanded(
                    child: ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index){
                    
                          QueryDocumentSnapshot taskDocument = documents[index];
                    
                          return Card(
                            color: Colors.cyan[50],
                            child: ListTile(
                              leading: Checkbox(
                                  value: taskDocument['isCompleted'],
                                  onChanged: (bool? checked) async{
                    
                                    await taskDocument.reference.update({
                                      'isCompleted': checked
                                    });
                    
                              }),
                            
                              title: Text(taskDocument['taskName']),
                              subtitle: Text(getFormattedDate(taskDocument['createdOn'])),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(onPressed: (){
                                    showModalBottomSheet(context: context, builder: (bsContext){
                    
                                      var taskNameController = TextEditingController(text: taskDocument['taskName']);
                    
                                      return Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: taskNameController,
                                            ),
                                            ElevatedButton(onPressed: () async {
                    
                                              String updatedTaskName = taskNameController.text.trim();
                                              await taskDocument.reference.update({
                                                'taskName': updatedTaskName
                                              });
                    
                    
                                              Navigator.of(bsContext).pop();
                    
                                            }, child: Text('Update')),
                                          ],
                                        ),
                                      );
                                    });
                                  }, icon: Icon(Icons.edit)),
                                  IconButton(onPressed: (){
                    
                                    showDialog(context: context, builder: (context){
                                      return AlertDialog(
                                        title: Text('Confirmation'),
                                        content: Text("Are you sure to Delete ? "),
                                        actions: [
                                          TextButton(onPressed: (){
                                            Navigator.of(context).pop();
                                          }, child: Text('No')),
                                          TextButton(onPressed: () async {
                    
                                          await  taskDocument.reference.delete();
                    
                                          Navigator.of(context).pop();
                    
                                          }, child: Text('Yes')),
                    
                    
                                        ],
                                      );
                                    });
                                  }, icon: Icon(Icons.delete)),
                                ],
                              ),
                            ),
                          );
                    
                        }),
                  ),
                ],
              );


            }else{
              return Center(child: SpinKitPumpingHeart(color: Colors.green,),);
            }
          }),
    );
  }
}
