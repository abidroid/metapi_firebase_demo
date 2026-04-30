import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dashboard_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  Timer? timer;

  //when screen appears, this function is called once
  @override
  void initState() {
    super.initState(); // ✅ super.initState() should be called FIRST
    _sendVerificationEmail();

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerification();
    });
  }

  Future<void> _sendVerificationEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  Future<void> checkEmailVerification() async {
    await FirebaseAuth.instance.currentUser!.reload(); // ✅ await reload first

    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      timer?.cancel(); // ✅ cancel timer before navigating
      if (mounted) {  // ✅ check if widget is still in tree
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 20,
          children: [
            Text('Confirm Email'),
            Text('We have sent you a confirmation email.\nPlease verify your email'),
            SpinKitDualRing(color: Colors.cyan, size: 60,),
            ElevatedButton(onPressed: (){

              FirebaseAuth.instance.currentUser!.sendEmailVerification();
            }, child: const Text('Resend Verification Email')),
          ],
        ),
      ),
    );
  }
}
