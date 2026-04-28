import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var nameC = TextEditingController();
  var phoneC = TextEditingController();
  var emailC = TextEditingController();
  var passwordC = TextEditingController();
  var confirmPasswordC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: Text("Sign Up Screen"),
      ),body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
        children: [
          TextField(
            controller: nameC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Name",
            ),),

          SizedBox(height: 25,),

          TextField(
            controller: phoneC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Phone",
            ),),

          SizedBox(height: 25,),

          TextField(
            controller: emailC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Email",
            ),),

          SizedBox(height: 25,),

          TextField(
            controller: passwordC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Password",
            ),),

          SizedBox(height: 25,),

          TextField(
            controller: confirmPasswordC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Confirm Password",
            ),),

          SizedBox(height: 25,),

          ElevatedButton(onPressed: (){}, child: Text("REGISTER")),
        ],
            ),
      ),

    );
  }
}
