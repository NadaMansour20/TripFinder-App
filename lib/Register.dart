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
  String? email; //
  String? pass; //
  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  bool isLoading=false;
  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formkey1,
          child: SingleChildScrollView(
            // Wrap with SingleChildScrollView
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
                            color: Color(0xFFBA68C8), // Light purple color
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    //شيلت الconst

                    hintText: "User Name",
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
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    onTap: () async {
                      if(formkey1.currentState!.validate()){
                        isLoading=true;
                        setState(() {

                        });
                        //بيانات جاية من المستقب
                        try {
                          await userRegister(); //
                          showSnackBar(context, 'Operation Success');
                          Navigator.pushReplacementNamed(context, Login.routName);
                          // Navigator.pushNamed(context, Register.routName);
                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == 'weak-password') {
                            showSnackBar(context, 'weak-password');
                          } else if (ex.code == 'email-already-in-use') {
                            //email already exists
                            showSnackBar(context, 'email already exists');
                          }
                        } catch (ex) {
                          showSnackBar(context, 'there was an error');
                        }
                        isLoading=false;
                        setState(() {

                        });
                      }
                      else{}
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

  Future<void> userRegister() async {
    UserCredential user = await //
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: pass!); //
  }

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }
}
