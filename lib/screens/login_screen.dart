import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/screens/dashboard_screen.dart';
import 'package:firebase_practice/screens/email_verification_screen.dart';
import 'package:firebase_practice/screens/forgot_password.dart';
import 'package:firebase_practice/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailC = TextEditingController();
  var passwordC = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.cyanAccent, title: Text("LOGIN")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
              controller: emailC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: passwordC,
              keyboardType: TextInputType.text,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
                suffixIcon: IconButton(onPressed: (){

                setState(() {

                  _obscurePassword = !_obscurePassword;

                  // method 2
                 // _obscurePassword = _obscurePassword ? false : true;

                  //
                  // method 1
                  // if( _obscurePassword == true){
                  //   _obscurePassword = false;
                  // }
                  // else{
                  //   _obscurePassword = true;
                  // }
                });
                }, icon: Icon( _obscurePassword ? Icons.visibility : Icons.visibility_off))
              ),
            ),

            SizedBox(height: 20),

            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ForgotPassword();
                    },
                  ),
                );
              },
              child: Text("Forgot Password?"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                String email = emailC.text.trim();
                String password = passwordC.text.trim();

                if (email.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please provide email');
                  return;
                }

                if (password.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please provide password');
                  return;
                }

                // after successful login
                FirebaseAuth auth = FirebaseAuth.instance;

                try{
                  UserCredential userCredential =  await auth.signInWithEmailAndPassword(email: email, password: password);

                  if( userCredential.user != null ){

                    // check if email is verified

                    if( FirebaseAuth.instance.currentUser!.emailVerified){
                      //

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return DashboardScreen();
                          },
                        ),
                      );
                    }else{


                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return EmailVerificationScreen();
                          },
                        ),
                      );
                    }
                  }
                }catch(e){

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString()))
                  );
                }




              },
              child: Text("Login"),
            ),

            SizedBox(height: 20),

            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SignupScreen();
                    },
                  ),
                );
              },
              child: Text("Can't login yet? Create Account"),
            ),
          ],
        ),
      ),
    );
  }
}
