import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tripfinder_app/CustomWidgets/CustomButton.dart';
import 'package:tripfinder_app/CustomWidgets/CustomTextField.dart';

import 'Login.dart';

class Register extends StatefulWidget {
  static const String routName = "register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;
  String? pass;
  String? username; // لإضافة اسم المستخدم
  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  bool isLoading = false;
  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;
  String? confirmPass;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formkey1,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Image.asset("assets/images/register_logo.jpg"),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Sign Up!',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFBA68C8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: "User Name",
                    onChanged: (data) {
                      username = data; // تخزين اسم المستخدم
                    },
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
                    hintText: "Password",
                    isPasswordField: true,
                    isObscure: _isPasswordObscure,
                    onSuffixIconTap: () {
                      setState(() {
                        _isPasswordObscure = !_isPasswordObscure;
                      });
                    },
                    onChanged: (data) {
                      pass = data;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: "Confirm Password",
                    isPasswordField: true,
                    isObscure: _isConfirmPasswordObscure,
                    onSuffixIconTap: () {
                      setState(() {
                        _isConfirmPasswordObscure = !_isConfirmPasswordObscure;
                      });
                    },
                    onChanged: (data) {
                      confirmPass = data;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    onTap: () async {
                      if (formkey1.currentState!.validate()) {
                        if (pass == confirmPass) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await userRegister();
                            showAlertDialog(context, 'Operation Success');
                            Navigator.pushReplacementNamed(
                                context, Login.routName);
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'weak-password') {
                              showAlertDialog(context, 'Weak password');
                            } else if (ex.code == 'email-already-in-use') {
                              showAlertDialog(context, 'Email already exists');
                            }
                          } catch (ex) {
                            showAlertDialog(context, 'There was an error');
                          }
                          isLoading = false;
                          setState(() {});
                        }
                        else{
                          showAlertDialog(context, 'Passwords do not match');
                        }
                      }
                    },
                    buttonText: "Sign UP",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // تسجيل المستخدم وتخزين البيانات في Firestore
  Future<void> userRegister() async {
    // إنشاء مستخدم جديد باستخدام البريد وكلمة المرور
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: pass!);

    // بعد تسجيل المستخدم، نقوم بتخزين بياناته في Firestore
    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
      'username': username,
      'email': email,
      'password': pass,
    });
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