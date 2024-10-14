import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tripfinder_app/CustomWidgets/CustomButton.dart';
import 'package:tripfinder_app/CustomWidgets/CustomTextField.dart';
import 'package:tripfinder_app/MainScreen.dart';
import 'package:tripfinder_app/Register.dart';

class Login extends StatefulWidget {
  static const String routName = "login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isPasswordObscure = true;
  String? email;
  String? pass;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isLoading = false;

  CollectionReference userLoginData = FirebaseFirestore.instance.collection('userLoginData');

  Future<void> addUserLoginData() {
    return userLoginData
        .add({
      "email": email,
      "pass": pass
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Image.asset("assets/images/register_logo.jpg"),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: const Row(
                      children: [
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFBA68C8), // Light purple color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFBA68C8), // Light purple color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: "Email",
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    onChanged: (data) {
                      pass = data;
                    },
                    hintText: "Password",
                    isPasswordField: true,
                    isObscure: _isPasswordObscure,
                    onSuffixIconTap: () {
                      setState(() {
                        _isPasswordObscure = !_isPasswordObscure;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});

                        try {
                          await userlogin();
                          showAlertDialog(context, 'Operation Success');
                          Navigator.pushReplacementNamed(context, MainScreen.routName);
                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == 'user-not-found') {
                            showAlertDialog(context, 'User not found');
                          } else if (ex.code == 'wrong-password') {
                            showAlertDialog(context, 'Wrong password');
                          }
                        } catch (ex) {
                          showAlertDialog(context, 'There was an error');
                        }

                        isLoading = false;
                        setState(() {});
                      } else {}
                      addUserLoginData();
                    },
                    buttonText: "Sign In",
                  ),
                  Row(
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Register.routName);
                        },
                        child: const Text(
                          " REGISTER",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFBA68C8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> userlogin() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: pass!);
  }

  void showAlertDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(msg),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}