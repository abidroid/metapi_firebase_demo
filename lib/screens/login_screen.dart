import 'package:firebase_practice/screens/dashboard_screen.dart';
import 'package:firebase_practice/screens/forgot_password.dart';
import 'package:firebase_practice/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailC = TextEditingController();
  var passwordC = TextEditingController();

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
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
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
              onPressed: () {
                String email = emailC.text.trim();
                String password = passwordC.text.trim();

                if (email.isEmpty) {}
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return DashboardScreen();
                    },
                  ),
                );
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
