import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  String? selectedGender = 'Male'; // 'Male, 'Female', 'Other'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: Text("Sign Up Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nameC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Name",
              ),
            ),

            SizedBox(height: 25),

            Text('Gender'),
            RadioGroup<String>(
              groupValue: selectedGender,
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue;
                });
              },
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio(value: 'Male'),
                      Text('Male'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(value: 'Female'),
                      Text('Female'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(value: 'Other'),
                      Text('Other'),
                    ],
                  ),
                ],
              ),
            ),

            TextField(
              controller: phoneC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Phone",
              ),
            ),

            SizedBox(height: 25),

            TextField(
              controller: emailC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
            ),

            SizedBox(height: 25),

            TextField(
              controller: passwordC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
            ),

            SizedBox(height: 25),

            TextField(
              controller: confirmPasswordC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Confirm Password",
              ),
            ),

            SizedBox(height: 25),

            ElevatedButton(onPressed: () async {
              // Front End Validations

              // 1. Empty
              // 2. password should be 8 or more characters long
              // 3. passwords should match
              // 4. password visibility toggle

              String name = nameC.text.trim();
              String phone = phoneC.text.trim();
              String email = emailC.text.trim();
              String password = passwordC.text.trim();

              if( password.length < 6 ){
                Fluttertoast.showToast(msg: 'Weak Password');
                return;
              }


              FirebaseAuth auth = FirebaseAuth.instance;

              try{
                UserCredential? userCredentials =  await auth.createUserWithEmailAndPassword(email: email, password: password);

                if( userCredentials.user != null ){
                  String userId = userCredentials.user!.uid!;
                  // now store the user info inside database

                }

              } catch (e){

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString()))
                );
              }


            }, child: Text("REGISTER")),
          ],
        ),
      ),
    );
  }
}
