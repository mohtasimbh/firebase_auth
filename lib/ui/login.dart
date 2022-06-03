import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:traval/const/appstyle.dart';
import 'package:traval/const/button.dart';
import 'package:traval/const/text_field.dart';
import 'package:traval/ui/create_account.dart';
import 'package:traval/ui/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == null || password == null) {
      Fluttertoast.showToast(
          msg: "Please fill all the fields!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0
      );
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Fluttertoast.showToast(
              msg: "Login Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0
          );
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => Home()));
        }
      } on FirebaseAuthException catch (ex) {
        print(ex.code.toString());
        Fluttertoast.showToast(
            msg: "Something error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text("LOGIN"),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomeTextField(
              title: "Your Email Address",
              hintText: "Enter Your Email Address",
              controller: emailController,
              icon: Padding(
                padding: const EdgeInsets.all(15),
                child: Icon(
                  Icons.email_outlined,
                  color: Color(0xFF8A8A8E),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomeTextField(
              title: "Your Password",
              hintText: "Enter your Password",
              controller: passwordController,
              icon: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(Icons.lock, color: Color(0xFF8A8A8E))),
            ),
            SizedBox(
              height: 30,
            ),
            CupertinoButton(
              onPressed: () {
                login();
              },
              color: Color(0xFF5EDFFF),
              child: Text("Login"),
            ),
            SizedBox(
              height: 15,
            ),
            Text("Forgot Password",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFF8F8F8))),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CreateAccount()));
                },
                child: Text(
                  "Create New account",
                  style: textStyle,
                ))
          ],
        ),
      ),
    );
  }
}
