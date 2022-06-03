import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:traval/const/appstyle.dart';
import 'package:traval/ui/home.dart';
import 'package:traval/ui/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => (FirebaseAuth.instance.currentUser != null) ? Home() : Login())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("CTG Tourist Gang",style: textStyle30,),
            SizedBox(height: 30),
            CircularProgressIndicator(color: Colors.white,),
          ],
        ),
      ),
    );
  }
}
