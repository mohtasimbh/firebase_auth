import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:traval/const/appstyle.dart';
import 'package:traval/const/button.dart';
import 'package:traval/const/text_field.dart';
import 'package:traval/ui/home.dart';
import 'package:traval/ui/login.dart';
import 'package:traval/ui/update_profile.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cpassword = cpasswordController.text.trim();
    if (password == null || password == null || cpassword == null) {
      Fluttertoast.showToast(
          msg: "Please fill all the details",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0
      );
    } else if (password != cpassword) {
      Fluttertoast.showToast(
          msg: "Password Did not Match",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0
      );
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Fluttertoast.showToast(
              msg: "Create Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0
          );
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => UpdateProfile()));
        }
      } on FirebaseAuthException catch (ex) {
        print(ex.code.toString());
        Fluttertoast.showToast(
            msg: "Something Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text("Create New Account"),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
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
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                }

                if (value.length > 15) {
                  return "";
                }

                if (value.length < 3) {
                  return "";
                }
              },
            ),
            CustomeTextField(
              title: "Your Password",
              hintText: "Enter your Password",
              controller: passwordController,
              icon: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(Icons.lock, color: Color(0xFF8A8A8E))),
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                }

                if (value.length > 15) {
                  return "";
                }

                if (value.length < 3) {
                  return "";
                }
              },
            ),
            CustomeTextField(
              title: "Confirm Password",
              hintText: "Enter your Password",
              controller: cpasswordController,
              icon: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(Icons.lock, color: Color(0xFF8A8A8E))),
            ),
            SizedBox(
              height: 8,
            ),
            CupertinoButton(
              onPressed: () {
                createAccount();
              },
              color: Color(0xFF5EDFFF),
              child: Text("Create Account"),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text(
                  "Already Account",
                  style: textStyle,
                )),
          ],
        ),
      ),
    );
  }
}
