import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  var emailC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: Text("FORGOT PASSWORD"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 20,
          children: [
            TextField(
              controller: emailC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),),

            ElevatedButton(onPressed: (){

              String email = emailC.text.trim();

              FirebaseAuth auth = FirebaseAuth.instance;

              auth.sendPasswordResetEmail(email: email);

            }, child: Text("Send Password Reset Email")),
          ],
        ),
      ),
    );
  }
}
